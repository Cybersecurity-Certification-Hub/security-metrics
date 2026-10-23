package cch.metrics.mitigated_network_attacks

import rego.v1

test_compliant_when_coveredAttackTypes_is_valid if {
	fixture := {"type": ["PolicyDocument"], "networkThreatMitigationPolicy": {"coveredAttackTypes": ["ddos", "phishing"]}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_coveredAttackTypes_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "networkThreatMitigationPolicy": {"coveredAttackTypes": ["phishing"]}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "networkThreatMitigationPolicy.coveredAttackTypes"
	rs[0].value == ["phishing"]
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

# protojson omits empty repeated fields, so a missing list means no attack types are covered
test_not_compliant_has_details_when_coveredAttackTypes_is_missing if {
	fixture := {"type": ["PolicyDocument"], "networkThreatMitigationPolicy": {"otherField": true}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].value == []
	rs[0].success == false
}

test_not_applicable_when_policy_is_missing if {
	fixture := {"type": ["PolicyDocument"]}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "networkThreatMitigationPolicy": {"coveredAttackTypes": ["ddos", "phishing"]}}
	not applicable with input as fixture
}
