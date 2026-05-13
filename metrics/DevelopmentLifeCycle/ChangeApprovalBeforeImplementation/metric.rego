package cch.metrics.change_approval_before_implementation

import data.cch.compare
import rego.v1
import input as resource

default applicable := false

default compliant := false

applicable if {
	resource.changeAndConfigurationManagement
}

compliant if {
    compare(data.operator, data.target_value, resource.changeAndConfigurationManagement.requestForChange.approvedBeforeImplementation)
}
