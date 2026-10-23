package cch.metrics.access_control_type

import rego.v1

test_compliant_when_authorizationTypes_is_valid if {
	fixture := {"type": ["PolicyDocument"], "accessControlTypePolicy": {"authorizationTypes": ["RBAC"]}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_authorizationTypes_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "accessControlTypePolicy": {"authorizationTypes": ["ABAC"]}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "accessControlTypePolicy.authorizationTypes"
	rs[0].value == ["ABAC"]
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

test_not_applicable_when_authorizationTypes_is_missing if {
	fixture := {"type": ["PolicyDocument"], "accessControlTypePolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "accessControlTypePolicy": {"authorizationTypes": ["RBAC"]}}
	not applicable with input as fixture
}
