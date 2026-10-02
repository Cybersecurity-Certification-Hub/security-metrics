package cch.metrics.change_control_register_completeness

import rego.v1

test_compliant_when_mandatoryFieldCompletenessPercent_is_valid if {
	fixture := {"type": ["PolicyDocument"], "changeAndConfigurationManagement": {"requestForChange": {"mandatoryFieldCompletenessPercent": 100}}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_mandatoryFieldCompletenessPercent_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "changeAndConfigurationManagement": {"requestForChange": {"mandatoryFieldCompletenessPercent": 60}}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_mandatoryFieldCompletenessPercent_is_missing if {
	fixture := {"type": ["PolicyDocument"], "changeAndConfigurationManagement": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "changeAndConfigurationManagement": {"requestForChange": {"mandatoryFieldCompletenessPercent": 100}}}
	not applicable with input as fixture
}
