package cch.metrics.change_approval_before_deployment

import data.cch.compare
import data.cch.comparison_result
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

results := [comparison_result("changeAndConfigurationManagement.requestForChange.approvedBeforeDeployment", ccm.requestForChange.approvedBeforeDeployment)]
