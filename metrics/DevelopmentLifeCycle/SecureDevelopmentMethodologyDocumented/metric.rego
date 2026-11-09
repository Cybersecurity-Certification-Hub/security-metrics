package cch.metrics.secure_development_methodology_documented

import data.cch.all_compliant
import data.cch.comparison_result
import input.secureDevelopmentPolicy as secureDevelopmentPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"referencesIndustryFramework" in object.keys(secureDevelopmentPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The Secure Development Methodology references an industry framework." if {
	compliant
} else := "The Secure Development Methodology does not reference an industry framework." if {
	not compliant
}

results := [comparison_result("secureDevelopmentPolicy.referencesIndustryFramework", secureDevelopmentPolicy.referencesIndustryFramework)]
