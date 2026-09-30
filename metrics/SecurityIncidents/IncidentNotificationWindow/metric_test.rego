package cch.metrics.incident_notification_window

import rego.v1

test_compliant_when_notificationWindowHours_is_valid if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {"notificationWindowHours": 24}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_notificationWindowHours_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {"notificationWindowHours": 96}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_notificationWindowHours_is_missing if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "securityIncident": {"notificationWindowHours": 24}}
	not applicable with input as fixture
}
