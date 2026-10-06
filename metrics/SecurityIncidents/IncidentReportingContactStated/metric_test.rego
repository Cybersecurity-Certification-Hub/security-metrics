package cch.metrics.incident_reporting_contact_stated

import rego.v1

test_compliant_when_team_is_valid if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {"team": ["security@example.com"]}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_team_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {"team": []}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "securityIncident.team"
	rs[0].value == []
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

# protojson omits empty repeated fields, so a missing team means no contact is stated
test_not_compliant_has_details_when_team_is_missing if {
	fixture := {"type": ["PolicyDocument"], "securityIncident": {}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].value == []
	rs[0].success == false
}

test_not_applicable_when_security_incident_is_missing if {
	fixture := {"type": ["PolicyDocument"]}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "securityIncident": {"team": ["security@example.com"]}}
	not applicable with input as fixture
}
