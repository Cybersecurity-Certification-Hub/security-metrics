package cch.metrics.device_checklist_coverage

import rego.v1

test_compliant_when_mandatedControlsCount_is_valid if {
	fixture := {"type": ["PolicyDocument"], "deviceManagementPolicy": {"mandatedControlsCount": 5}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_mandatedControlsCount_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "deviceManagementPolicy": {"mandatedControlsCount": 4}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "deviceManagementPolicy.mandatedControlsCount"
	rs[0].value == 4
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

test_not_applicable_when_mandatedControlsCount_is_missing if {
	fixture := {"type": ["PolicyDocument"], "deviceManagementPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "deviceManagementPolicy": {"mandatedControlsCount": 5}}
	not applicable with input as fixture
}
