package cch.metrics.change_approval_before_implementation

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document.changeAndConfigurationManagement
}

compliant if {
    compare(data.operator, data.target_value, document.changeAndConfigurationManagement.requestForChange.approvedBeforeImplementation)
}
