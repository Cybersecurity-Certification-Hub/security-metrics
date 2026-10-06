package cch.metrics.security_training_cadence

import rego.v1

test_compliant_when_annualCadenceStated_is_valid if {
	fixture := {"type": ["PolicyDocument"], "awarenessTraining": {"annualCadenceStated": "annually"}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_annualCadenceStated_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "awarenessTraining": {"annualCadenceStated": "every two years"}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "awarenessTraining.annualCadenceStated"
	rs[0].value == "every two years"
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

test_not_applicable_when_annualCadenceStated_is_missing if {
	fixture := {"type": ["PolicyDocument"], "awarenessTraining": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "awarenessTraining": {"annualCadenceStated": "annually"}}
	not applicable with input as fixture
}
