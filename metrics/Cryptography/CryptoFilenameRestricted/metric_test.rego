package cch.metrics.crypto_filename_restricted

import rego.v1

test_compliant_when_nonDescriptiveFilenameRequired_is_valid if {
	fixture := {"type": ["PolicyDocument"], "cryptographicTransferPolicy": {"nonDescriptiveFilenameRequired": true}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_nonDescriptiveFilenameRequired_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "cryptographicTransferPolicy": {"nonDescriptiveFilenameRequired": false}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_nonDescriptiveFilenameRequired_is_missing if {
	fixture := {"type": ["PolicyDocument"], "cryptographicTransferPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "cryptographicTransferPolicy": {"nonDescriptiveFilenameRequired": true}}
	not applicable with input as fixture
}
