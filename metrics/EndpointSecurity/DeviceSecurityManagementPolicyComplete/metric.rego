package cch.metrics.device_security_management_policy_complete

import data.cch.comparison_result
import rego.v1
import input.deviceManagementPolicy as deviceManagementPolicy

default applicable := false
default compliant := false

applicable if {
	"allMandatedControlsAddressed" in object.keys(deviceManagementPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The procedure addresses all 7 mandated device controls." if {
	compliant
} else := "The procedure does not address all 7 mandated device controls." if {
	not compliant
}

results := [comparison_result("deviceManagementPolicy.allMandatedControlsAddressed", deviceManagementPolicy.allMandatedControlsAddressed)]
