package cch.metrics.virtual_machine_public_ip_disabled

import data.cch.all_compliant
import data.cch.comparison_result
import input as vm
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"VirtualMachine" in vm.type
	is_boolean(vm.internetAccessibleEndpoint)
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("internetAccessibleEndpoint", vm.internetAccessibleEndpoint)]
