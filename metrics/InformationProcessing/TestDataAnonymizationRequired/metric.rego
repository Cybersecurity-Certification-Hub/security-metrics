package cch.metrics.test_data_anonymization_required

import data.cch.all_compliant
import data.cch.comparison_result
import input.testDataPolicy as testDataPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"anonymizationRequiredForNonProd" in object.keys(testDataPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The procedure requires anonymization/pseudonymization/fictitious data for non-production environments." if {
	compliant
} else := "The procedure does not require anonymization/pseudonymization/fictitious data for non-production environments." if {
	not compliant
}

results := [comparison_result("testDataPolicy.anonymizationRequiredForNonProd", testDataPolicy.anonymizationRequiredForNonProd)]
