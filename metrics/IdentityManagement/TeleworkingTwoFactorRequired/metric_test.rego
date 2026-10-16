package cch.metrics.teleworking_two_factor_required

import rego.v1

test_compliant_when_twoFactorRequired_is_valid if {
	fixture := {"type": ["PolicyDocument"], "teleworkingPolicy": {"twoFactorRequired": ["two-factor authentication"]}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_twoFactorRequired_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "teleworkingPolicy": {"twoFactorRequired": ["not an accepted answer"]}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "teleworkingPolicy.twoFactorRequired"
	rs[0].value == ["not an accepted answer"]
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

test_not_applicable_when_twoFactorRequired_is_missing if {
	fixture := {"type": ["PolicyDocument"], "teleworkingPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "teleworkingPolicy": {"twoFactorRequired": ["two-factor authentication"]}}
	not applicable with input as fixture
}
