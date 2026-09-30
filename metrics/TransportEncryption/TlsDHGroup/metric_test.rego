package cch.metrics.tls_dh_group

import rego.v1

test_compliant_when_dh_group_is_allowed if {
	fixture := {"transportEncryption": {"dhGroup": "2048"}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_dh_group_is_too_weak if {
	fixture := {"transportEncryption": {"dhGroup": "1024"}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_dh_group_is_missing if {
	fixture := {"transportEncryption": {"cipherSuite": ["TLS_AES_128_GCM_SHA256"]}}
	not applicable with input as fixture
}

test_not_applicable_when_no_transport_encryption_present if {
	fixture := {"type": ["NetworkService"]}
	not applicable with input as fixture
}

test_finds_transport_encryption_at_any_nesting_level if {
	fixture := {"nic": {"transportEncryption": {"dhGroup": "3072"}}}
	applicable with input as fixture
	compliant with input as fixture
}
