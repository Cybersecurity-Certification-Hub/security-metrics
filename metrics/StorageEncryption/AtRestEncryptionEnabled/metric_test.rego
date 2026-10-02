package cch.metrics.at_rest_encryption_enabled

import rego.v1

test_compliant_when_enabled_is_true if {
	fixture := {"type": ["Storage"], "atRestEncryption": {"disk1": {"enabled": true}}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_enabled_is_false if {
	fixture := {"type": ["Storage"], "atRestEncryption": {"disk1": {"enabled": false}}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_resource_is_not_storage if {
	fixture := {"type": ["Compute"], "atRestEncryption": {"disk1": {"enabled": true}}}
	not applicable with input as fixture
}

test_not_applicable_when_enabled_key_is_missing if {
	fixture := {"type": ["Storage"], "atRestEncryption": {"disk1": {"algorithm": "AES256"}}}
	not applicable with input as fixture
}

test_results_property_is_namespaced_by_resource_key if {
	fixture := {"type": ["Storage"], "atRestEncryption": {"disk1": {"enabled": true}}}
	r := results with input as fixture
	r == [{
		"property": "atRestEncryption.disk1.enabled",
		"value": true,
		"target_value": true,
		"operator": "==",
		"success": true,
	}]
}
