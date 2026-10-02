package cch.metrics.at_rest_encryption_algorithm

import rego.v1

test_compliant_when_algorithm_matches_target if {
	fixture := {"type": ["Storage"], "atRestEncryption": {"disk1": {"algorithm": "AES256"}}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_algorithm_mismatches_target if {
	fixture := {"type": ["Storage"], "atRestEncryption": {"disk1": {"algorithm": "AES128"}}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_resource_is_not_storage if {
	fixture := {"type": ["Compute"], "atRestEncryption": {"disk1": {"algorithm": "AES256"}}}
	not applicable with input as fixture
}

test_not_applicable_when_algorithm_key_is_missing if {
	fixture := {"type": ["Storage"], "atRestEncryption": {"disk1": {"enabled": true}}}
	not applicable with input as fixture
}

test_results_property_is_namespaced_by_resource_key if {
	fixture := {"type": ["Storage"], "atRestEncryption": {"disk1": {"algorithm": "AES256"}}}
	r := results with input as fixture
	r == [{
		"property": "atRestEncryption.disk1.algorithm",
		"value": "AES256",
		"target_value": "AES256",
		"operator": "==",
		"success": true,
	}]
}

test_compliant_when_any_resource_matches_among_several if {
	fixture := {"type": ["Storage"], "atRestEncryption": {
		"disk1": {"algorithm": "AES128"},
		"disk2": {"algorithm": "AES256"},
	}}
	applicable with input as fixture
	compliant with input as fixture
}
