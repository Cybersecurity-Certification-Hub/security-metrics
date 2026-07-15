package cch.metrics.change_approval_before_deployment

import data.cch.compare
import rego.v1
import input.changeAndConfigurationManagement as ccm

default applicable := false

default compliant := false

applicable if {
	ccm
}

compliant if {
    compare(data.operator, data.target_value, ccm.requestForChange.approvedBeforeDeployment)
}
