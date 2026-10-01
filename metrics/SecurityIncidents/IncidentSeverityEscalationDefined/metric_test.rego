package cch.metrics.incident_severity_escalation_defined

import rego.v1

test_compliant_when_severityAndEscalationDefined_is_valid if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {"severityAndEscalationDefined": ["SOC shift lead"]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_severityAndEscalationDefined_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {"severityAndEscalationDefined": ["not an accepted answer"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_severityAndEscalationDefined_is_missing if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "securityIncident": {"severityAndEscalationDefined": ["SOC shift lead"]}}
	not applicable with input as fixture
}
