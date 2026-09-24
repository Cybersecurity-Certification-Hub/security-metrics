package cch.metrics.anonymization_technique_named

import data.cch.comparison_result
import rego.v1
import input.testDataPolicy as testDataPolicy

default applicable := false
default compliant := false

applicable if {
	"technique" in object.keys(testDataPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The procedure names a specific anonymization technique or standard used." if {
	compliant
} else := "The procedure does not name a specific anonymization technique or standard used." if {
	not compliant
}

results := [comparison_result("testDataPolicy.technique", testDataPolicy.technique)]
