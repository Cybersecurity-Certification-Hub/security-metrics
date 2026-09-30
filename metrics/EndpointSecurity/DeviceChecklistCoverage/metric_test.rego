package cch.metrics.device_checklist_coverage

import rego.v1

test_compliant_when_checklistCoveragePercent_is_valid if {
	fixture := {"type": ["PolicyDocument"], "deviceManagementPolicy": {"checklistCoveragePercent": 100}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_checklistCoveragePercent_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "deviceManagementPolicy": {"checklistCoveragePercent": 60}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_checklistCoveragePercent_is_missing if {
	fixture := {"type": ["PolicyDocument"], "deviceManagementPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "deviceManagementPolicy": {"checklistCoveragePercent": 100}}
	not applicable with input as fixture
}
