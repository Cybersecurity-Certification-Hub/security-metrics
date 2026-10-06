package cch.metrics.security_training_plan_documented

import rego.v1

test_compliant_when_planDocumented_is_valid if {
	fixture := {"type": ["PolicyDocument"], "awarenessTraining": {"planDocumented": "training plan"}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_planDocumented_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "awarenessTraining": {"planDocumented": "no plan stated"}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "awarenessTraining.planDocumented"
	rs[0].value == "no plan stated"
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

test_not_applicable_when_planDocumented_is_missing if {
	fixture := {"type": ["PolicyDocument"], "awarenessTraining": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "awarenessTraining": {"planDocumented": "training plan"}}
	not applicable with input as fixture
}
