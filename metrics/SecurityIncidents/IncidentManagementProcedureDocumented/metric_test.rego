package cch.metrics.incident_management_procedure_documented

import rego.v1

test_compliant_when_registryAndSlaStated_is_valid if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {"registryAndSlaStated": true}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_registryAndSlaStated_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {"registryAndSlaStated": false}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_registryAndSlaStated_is_missing if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "securityIncident": {"registryAndSlaStated": true}}
	not applicable with input as fixture
}
