package cch.metrics.monitoring_log_data_enabled

import data.cch.compare
import rego.v1
import input as vm

default applicable := false

default compliant := false

applicable if {
	vm.type[_] == "VirtualMachine"
	logging := vm.activityLogging
	logging != null
	logging.monitoringLogDataEnabled != null
}

applicable if {
	vm.type[_] == "VirtualMachine"
	logging := vm.bootLogging
	logging != null
	logging.monitoringLogDataEnabled != null
}

applicable if {
	vm.type[_] == "VirtualMachine"
	logging := vm.osLogging
	logging != null
	logging.monitoringLogDataEnabled != null
}

applicable if {
	vm.type[_] == "VirtualMachine"
	logging := vm.resourceLogging
	logging != null
	logging.monitoringLogDataEnabled != null
}

applicable if {
	vm.type[_] == "VirtualMachine"
	mp := vm.malwareProtection
	mp != null
	logging := mp.applicationLogging
	logging != null
	logging.monitoringLogDataEnabled != null
}

non_compliant if {
	vm.type[_] == "VirtualMachine"
	logging := vm.activityLogging
	logging != null
	value := logging.monitoringLogDataEnabled
	value != null
	not compare(data.operator, data.target_value, value)
}

non_compliant if {
	vm.type[_] == "VirtualMachine"
	logging := vm.bootLogging
	logging != null
	value := logging.monitoringLogDataEnabled
	value != null
	not compare(data.operator, data.target_value, value)
}

non_compliant if {
	vm.type[_] == "VirtualMachine"
	logging := vm.osLogging
	logging != null
	value := logging.monitoringLogDataEnabled
	value != null
	not compare(data.operator, data.target_value, value)
}

non_compliant if {
	vm.type[_] == "VirtualMachine"
	logging := vm.resourceLogging
	logging != null
	value := logging.monitoringLogDataEnabled
	value != null
	not compare(data.operator, data.target_value, value)
}

non_compliant if {
	vm.type[_] == "VirtualMachine"
	mp := vm.malwareProtection
	mp != null
	logging := mp.applicationLogging
	logging != null
	value := logging.monitoringLogDataEnabled
	value != null
	not compare(data.operator, data.target_value, value)
}

compliant if {
	applicable
	not non_compliant
	compare(data.operator, data.target_value, true)
}
