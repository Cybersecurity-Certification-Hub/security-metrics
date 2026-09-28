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
	"target_value": data.cch.target_value,
	"operator": data.cch.operator,
	"success": all_sources_allowed,
}]

default all_sources_allowed := false

all_sources_allowed if {
	every source in l3.allowedSources {
		source_allowed(source)
	}
}

source_allowed(source) if source in data.target_value

source_allowed(source) if {
	r := address_range(source)
	some network in data.target_value
	not startswith(network, "vnet:")
	net.cidr_contains(network, r.first)
	net.cidr_contains(network, r.last)
}

address_range(source) := {"first": "0.0.0.0", "last": "255.255.255.255"} if source == "0.0.0.0/0"

address_range(source) := {"first": ip, "last": int_to_ip((ip_to_int(ip) + size) - 1)} if {
	source != "0.0.0.0/0"
	not startswith(source, "vnet:")
	parts := split(source, "/")
	ip := parts[0]
	size := range_size(parts)
	size >= 1
}

range_size(parts) := 1 if count(parts) == 1

range_size(parts) := to_number(parts[1]) if count(parts) == 2

ip_to_int(ip) := n if {
	octets := [to_number(x) | some x in split(ip, ".")]
	count(octets) == 4
	n := (((((octets[0] * 256) + octets[1]) * 256) + octets[2]) * 256) + octets[3]
}

int_to_ip(n) := concat(".", [format_int(floor(n / shift) % 256, 10) | some shift in [16777216, 65536, 256, 1]])
