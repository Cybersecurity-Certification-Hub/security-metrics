package cch.metrics.sdlc_checklist_coverage

import rego.v1

test_compliant_when_checklistCoveragePercent_is_valid if {
	fixture := {"type": ["PolicyDocument"], "secureDevelopmentPolicy": {"checklistCoveragePercent": 85}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_checklistCoveragePercent_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "secureDevelopmentPolicy": {"checklistCoveragePercent": 40}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_checklistCoveragePercent_is_missing if {
	fixture := {"type": ["PolicyDocument"], "secureDevelopmentPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "secureDevelopmentPolicy": {"checklistCoveragePercent": 85}}
	not applicable with input as fixture
}
