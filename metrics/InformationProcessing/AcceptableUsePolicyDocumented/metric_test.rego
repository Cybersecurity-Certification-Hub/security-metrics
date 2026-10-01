package cch.metrics.acceptable_use_policy_documented

import rego.v1

test_compliant_when_documentPurpose_is_valid if {
	fixture := {"type": ["PolicyDocument"], "acceptableUsePolicy": {"documentPurpose": ["acceptable use"]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_documentPurpose_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "acceptableUsePolicy": {"documentPurpose": ["not an accepted answer"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_documentPurpose_is_missing if {
	fixture := {"type": ["PolicyDocument"], "acceptableUsePolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "acceptableUsePolicy": {"documentPurpose": ["acceptable use"]}}
	not applicable with input as fixture
}
