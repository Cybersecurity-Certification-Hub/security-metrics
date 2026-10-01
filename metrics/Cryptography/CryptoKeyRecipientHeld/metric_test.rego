package cch.metrics.crypto_key_recipient_held

import rego.v1

test_compliant_when_recipientHeldKeyRequired_is_valid if {
	fixture := {"type": ["PolicyDocument"], "cryptographicTransferPolicy": {"recipientHeldKeyRequired": ["key known by the recipient"]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_recipientHeldKeyRequired_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "cryptographicTransferPolicy": {"recipientHeldKeyRequired": ["not an accepted answer"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_recipientHeldKeyRequired_is_missing if {
	fixture := {"type": ["PolicyDocument"], "cryptographicTransferPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "cryptographicTransferPolicy": {"recipientHeldKeyRequired": ["key known by the recipient"]}}
	not applicable with input as fixture
}
