package cch.metrics.security_alerts_enabled

import data.cch.compare
import rego.v1
import input as vm

default applicable := false

default compliant := false

applicable if {
	vm.type[_] == "VirtualMachine"
	logging := vm.activityLogging
	logging != null
	logging.securityAlertsEnabled != null
}

applicable if {
	vm.type[_] == "VirtualMachine"
	logging := vm.bootLogging
	logging != null
	logging.securityAlertsEnabled != null
}

applicable if {
	vm.type[_] == "VirtualMachine"
	logging := vm.osLogging
	logging != null
	logging.securityAlertsEnabled != null
}

applicable if {
	vm.type[_] == "VirtualMachine"
	logging := vm.resourceLogging
	logging != null
	logging.securityAlertsEnabled != null
}

applicable if {
	vm.type[_] == "VirtualMachine"
	mp := vm.malwareProtection
	mp != null
	logging := mp.applicationLogging
	logging != null
	logging.securityAlertsEnabled != null
}

non_compliant if {
	vm.type[_] == "VirtualMachine"
	logging := vm.activityLogging
	logging != null
	value := logging.securityAlertsEnabled
	value != null
	not compare(data.operator, data.target_value, value)
}

non_compliant if {
	vm.type[_] == "VirtualMachine"
	logging := vm.bootLogging
	logging != null
	value := logging.securityAlertsEnabled
	value != null
	not compare(data.operator, data.target_value, value)
}

non_compliant if {
	vm.type[_] == "VirtualMachine"
	logging := vm.osLogging
	logging != null
	value := logging.securityAlertsEnabled
	value != null
	not compare(data.operator, data.target_value, value)
}

non_compliant if {
	vm.type[_] == "VirtualMachine"
	logging := vm.resourceLogging
	logging != null
	value := logging.securityAlertsEnabled
	value != null
	not compare(data.operator, data.target_value, value)
}

non_compliant if {
	vm.type[_] == "VirtualMachine"
	mp := vm.malwareProtection
	mp != null
	logging := mp.applicationLogging
	logging != null
	value := logging.securityAlertsEnabled
	value != null
	not compare(data.operator, data.target_value, value)
}

compliant if {
	applicable
	not non_compliant
	compare(data.operator, data.target_value, true)
}
