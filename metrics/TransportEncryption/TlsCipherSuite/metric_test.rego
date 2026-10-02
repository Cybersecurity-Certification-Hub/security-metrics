package cch.metrics.tls_cipher_suite

import rego.v1

test_compliant_when_all_cipher_suites_are_allowed if {
	fixture := {"transportEncryption": {"cipherSuite": ["TLS_AES_128_GCM_SHA256", "TLS_CHACHA20_POLY1305"]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_a_weak_cipher_suite_is_also_offered if {
	# Regression test for #438: a single strong suite must not be enough to
	# pass if a weak/legacy suite is offered alongside it.
	fixture := {"transportEncryption": {"cipherSuite": ["TLS_AES_128_GCM_SHA256", "TLS_RSA_WITH_RC4_128_SHA"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_compliant_when_no_cipher_suite_is_allowed if {
	fixture := {"transportEncryption": {"cipherSuite": ["TLS_RSA_WITH_RC4_128_SHA"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_cipher_suite_is_missing if {
	fixture := {"transportEncryption": {"dhGroup": "2048"}}
	not applicable with input as fixture
}

test_not_applicable_when_cipher_suite_is_not_an_array if {
	fixture := {"transportEncryption": {"cipherSuite": "TLS_AES_128_GCM_SHA256"}}
	not applicable with input as fixture
}

test_not_applicable_when_no_transport_encryption_present if {
	fixture := {"type": ["NetworkService"]}
	not applicable with input as fixture
}

test_finds_transport_encryption_at_any_nesting_level if {
	fixture := {"nic": {"transportEncryption": {"cipherSuite": ["TLS_AES_128_GCM_SHA256"]}}}
	applicable with input as fixture
	compliant with input as fixture
}
