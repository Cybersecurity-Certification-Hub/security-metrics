package cch.metrics.test_data_anonymization_required

import rego.v1

test_compliant_when_anonymizationRequiredForNonProd_is_valid if {
	fixture := {"type": ["PolicyDocument"], "testDataPolicy": {"anonymizationRequiredForNonProd": ["anonymized"]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_anonymizationRequiredForNonProd_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "testDataPolicy": {"anonymizationRequiredForNonProd": ["not an accepted answer"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_anonymizationRequiredForNonProd_is_missing if {
	fixture := {"type": ["PolicyDocument"], "testDataPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "testDataPolicy": {"anonymizationRequiredForNonProd": ["anonymized"]}}
	not applicable with input as fixture
}
