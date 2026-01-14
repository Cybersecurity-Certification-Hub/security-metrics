package cch.metrics.public_ip_ddos_protection

import data.cch.compare
import rego.v1
import input as ip

default applicable := false

default compliant := false

applicable if {
	ip.type[_] == "PublicIpAddress"
	ddos := ip.dDoSProtection
	ddos != null
	ddos.enabled != null
}

compliant if {
	ip.type[_] == "PublicIpAddress"
	ddos := ip.dDoSProtection
	ddos != null
	value := ddos.enabled
	compare(data.operator, data.target_value, value)
}
