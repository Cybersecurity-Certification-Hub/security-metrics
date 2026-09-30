package cch.metrics.teleworking_encryption_required

import rego.v1

test_compliant_when_encryptionRequired_is_valid if {
	fixture := {"type": ["PolicyDocument"], "teleworkingPolicy": {"encryptionRequired": true}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_encryptionRequired_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "teleworkingPolicy": {"encryptionRequired": false}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_encryptionRequired_is_missing if {
	fixture := {"type": ["PolicyDocument"], "teleworkingPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "teleworkingPolicy": {"encryptionRequired": true}}
	not applicable with input as fixture
}
