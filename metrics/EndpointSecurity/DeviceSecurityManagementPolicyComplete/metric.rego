package cch.metrics.device_security_management_policy_complete

import data.cch.all_compliant
import data.cch.comparison_result
import input.deviceManagementPolicy as deviceManagementPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"mandatedControlsCount" in object.keys(deviceManagementPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The procedure addresses all 7 mandated device controls." if {
	compliant
} else := "The procedure does not address all 7 mandated device controls." if {
	not compliant
}

results := [comparison_result("deviceManagementPolicy.mandatedControlsCount", deviceManagementPolicy.mandatedControlsCount)]
