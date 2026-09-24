package cch.metrics.virtual_machine_public_ip_disabled

import data.cch.comparison_result
import rego.v1
import input as vm

default applicable = false
default compliant = false

applicable if {
    "VirtualMachine" in vm.type
    is_boolean(vm.internetAccessibleEndpoint)
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("internetAccessibleEndpoint", vm.internetAccessibleEndpoint)]
