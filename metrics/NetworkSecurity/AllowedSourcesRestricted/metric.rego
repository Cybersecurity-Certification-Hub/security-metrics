package cch.metrics.allowed_sources_restricted

import rego.v1
import input.accessRestriction.l3Firewall as l3

default applicable = false

default compliant = false

applicable if {
	l3.allowedSources
    # the resource type should be an Network Interface
	input.type[_] == "NetworkInterface"
}

compliant if {
	every r in results { r.success }
}

# The evidence describes each source the way OpenNebula stores it: "<ip>" for
# one address, "<ip>/<number of addresses>" for a range, "0.0.0.0/0" for any
# source and "vnet:<id>" for a virtual network. The target lists the allowed
# networks in CIDR notation, and may also list "vnet:<id>" entries literally.
# A source is allowed when the target lists it literally, or when its whole
# address range lies inside one allowed network.
results := [{
	"property": "accessRestriction.l3Firewall.allowedSources",
	"value": l3.allowedSources,
	"target_value": data.target_value,
	"operator": data.operator,
	"success": all_sources_allowed,
}]

default all_sources_allowed := false

all_sources_allowed if {
	every source in l3.allowedSources {
		source in allowed_source
	}
}

# allowed_source and address_range are partial rules rather than parameterized functions: this
# package is queried generically via object.get(data.<pkg>, ...), which OPA's type checker rejects
# if the package exports any function-typed member.
allowed_source contains source if {
	some source in l3.allowedSources
	source in data.target_value
}

allowed_source contains source if {
	some source in l3.allowedSources
	r := address_range[source]
	some network in data.target_value
	not startswith(network, "vnet:")
	net.cidr_contains(network, r.first)
	net.cidr_contains(network, r.last)
}

address_range[source] := {"first": "0.0.0.0", "last": "255.255.255.255"} if {
	some source in l3.allowedSources
	source == "0.0.0.0/0"
}

address_range[source] := {"first": ip, "last": last_ip} if {
	some source in l3.allowedSources
	source != "0.0.0.0/0"
	not startswith(source, "vnet:")
	parts := split(source, "/")
	ip := parts[0]

	# A single-part source ("<ip>") is a /1-address range; a two-part source ("<ip>/<count>")
	# spans that many consecutive addresses starting at ip. count(parts) is 1 or 2 for any valid
	# source, so exactly one of these comprehensions is non-empty.
	sizes := array.concat([1 | count(parts) == 1], [to_number(parts[1]) | count(parts) == 2])
	count(sizes) == 1
	size := sizes[0]
	size >= 1

	octets := [to_number(x) | some x in split(ip, ".")]
	count(octets) == 4
	ip_int := (((((octets[0] * 256) + octets[1]) * 256) + octets[2]) * 256) + octets[3]
	n := (ip_int + size) - 1
	last_ip := concat(".", [format_int(floor(n / shift) % 256, 10) | some shift in [16777216, 65536, 256, 1]])
}
