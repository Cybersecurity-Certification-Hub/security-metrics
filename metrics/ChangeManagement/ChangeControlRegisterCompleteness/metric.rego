package cch.metrics.change_control_register_completeness

import data.cch.comparison_result
import rego.v1
import input.changeAndConfigurationManagement as ccm

default applicable := false
default compliant := false

applicable if {
	"mandatoryFieldCompletenessPercent" in object.keys(ccm.requestForChange)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "All changes listed in the submitted Change Control Register have all mandatory fields filled in." if {
	compliant
} else := "Not all changes listed in the submitted Change Control Register have all mandatory fields filled in." if {
	not compliant
}

results := [comparison_result("changeAndConfigurationManagement.requestForChange.mandatoryFieldCompletenessPercent", ccm.requestForChange.mandatoryFieldCompletenessPercent)]
