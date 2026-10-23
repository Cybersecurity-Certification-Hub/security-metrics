package cch.metrics.iso_27001_certification_status

import rego.v1

test_compliant_when_iso27001Certified_is_valid if {
	fixture := {"type": ["PolicyDocument"], "informationSecurityManagementSystem": {"iso27001Certified": "compliant"}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_iso27001Certified_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "informationSecurityManagementSystem": {"iso27001Certified": "not certified"}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "informationSecurityManagementSystem.iso27001Certified"
	rs[0].value == "not certified"
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

test_not_applicable_when_iso27001Certified_is_missing if {
	fixture := {"type": ["PolicyDocument"], "informationSecurityManagementSystem": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "informationSecurityManagementSystem": {"iso27001Certified": "compliant"}}
	not applicable with input as fixture
}
