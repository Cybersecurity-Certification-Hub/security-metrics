package cch.metrics.change_approval_before_deployment

import data.cch.comparison_result
import rego.v1
import input.changeAndConfigurationManagement as ccm

default applicable := false

default compliant := false

applicable if {
	ccm
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("changeAndConfigurationManagement.requestForChange.approvedBeforeDeployment", ccm.requestForChange.approvedBeforeDeployment)]
