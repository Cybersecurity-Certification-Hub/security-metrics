package cch.metrics.acceptable_use_policy_scope_coverage

import rego.v1

test_compliant_when_mandatedAreaCoveragePercent_is_valid if {
	fixture := {"type": ["PolicyDocument"], "acceptableUsePolicy": {"mandatedAreaCoveragePercent": 100}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_mandatedAreaCoveragePercent_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "acceptableUsePolicy": {"mandatedAreaCoveragePercent": 55}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_mandatedAreaCoveragePercent_is_missing if {
	fixture := {"type": ["PolicyDocument"], "acceptableUsePolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "acceptableUsePolicy": {"mandatedAreaCoveragePercent": 100}}
	not applicable with input as fixture
}
