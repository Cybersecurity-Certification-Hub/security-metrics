package cch.metrics.anonymization_technique_named

import rego.v1

test_compliant_when_technique_is_valid if {
	fixture := {"type": ["PolicyDocument"], "testDataPolicy": {"technique": "masking"}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_technique_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "testDataPolicy": {"technique": "no technique named"}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_technique_is_missing if {
	fixture := {"type": ["PolicyDocument"], "testDataPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "testDataPolicy": {"technique": "masking"}}
	not applicable with input as fixture
}

test_not_compliant_has_details_when_technique_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "testDataPolicy": {"technique": "no technique named"}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "testDataPolicy.technique"
	rs[0].value == "no technique named"
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}
