package cch.metrics.anonymization_technique_named

import data.cch.all_compliant
import data.cch.comparison_result
import input.testDataPolicy as testDataPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"technique" in object.keys(testDataPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The procedure names a specific anonymization technique or standard used." if {
	compliant
} else := "The procedure does not name a specific anonymization technique or standard used." if {
	not compliant
}

results := [comparison_result("testDataPolicy.technique", testDataPolicy.technique)]
