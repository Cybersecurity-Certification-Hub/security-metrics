package cch.metrics.secure_development_methodology_documented

import rego.v1

test_compliant_when_referencesIndustryFramework_is_valid if {
	fixture := {"type": ["PolicyDocument"], "secureDevelopmentPolicy": {"referencesIndustryFramework": ["Secure Development"]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_referencesIndustryFramework_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "secureDevelopmentPolicy": {"referencesIndustryFramework": ["not an accepted answer"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_referencesIndustryFramework_is_missing if {
	fixture := {"type": ["PolicyDocument"], "secureDevelopmentPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "secureDevelopmentPolicy": {"referencesIndustryFramework": ["Secure Development"]}}
	not applicable with input as fixture
}
