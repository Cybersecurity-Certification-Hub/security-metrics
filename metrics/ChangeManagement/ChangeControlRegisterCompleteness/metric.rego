package cch.metrics.change_control_register_completeness

import data.cch.all_compliant
import data.cch.comparison_result
import input.changeAndConfigurationManagement as ccm
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"mandatoryFieldCompletenessPercent" in object.keys(ccm.requestForChange)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "All changes listed in the submitted Change Control Register have all mandatory fields filled in." if {
	compliant
} else := "Not all changes listed in the submitted Change Control Register have all mandatory fields filled in." if {
	not compliant
}

results := [comparison_result("changeAndConfigurationManagement.requestForChange.mandatoryFieldCompletenessPercent", ccm.requestForChange.mandatoryFieldCompletenessPercent)]
