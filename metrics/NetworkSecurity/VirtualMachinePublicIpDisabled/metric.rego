package cch.metrics.virtual_machine_public_ip_disabled

import data.cch.compare
import rego.v1
import input as vm

default applicable = false
default compliant = false

applicable if {
    "VirtualMachine" in vm.type
    is_boolean(vm.internetAccessibleEndpoint)
}

compliant if {
    compare(data.operator, data.target_value, vm.internetAccessibleEndpoint)
}
