package cch.metrics.incident_reporting_contact_stated

import rego.v1

test_compliant_when_reportingContacts_is_valid if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {"reportingContacts": ["designated contact"]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_reportingContacts_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {"reportingContacts": ["not an accepted answer"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_reportingContacts_is_missing if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "securityIncident": {"reportingContacts": ["designated contact"]}}
	not applicable with input as fixture
}
