package cch.metrics.test_data_anonymization_required

import data.cch.comparison_result
import rego.v1
import input.testDataPolicy as testDataPolicy

default applicable := false
default compliant := false

applicable if {
	"anonymizationRequiredForNonProd" in object.keys(testDataPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The procedure requires anonymization/pseudonymization/fictitious data for non-production environments." if {
	compliant
} else := "The procedure does not require anonymization/pseudonymization/fictitious data for non-production environments." if {
	not compliant
}

results := [comparison_result("testDataPolicy.anonymizationRequiredForNonProd", testDataPolicy.anonymizationRequiredForNonProd)]
