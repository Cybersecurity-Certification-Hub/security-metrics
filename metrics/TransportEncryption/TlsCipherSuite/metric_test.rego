package cch.metrics.tls_cipher_suite

import rego.v1

# TLS 1.3: TLS_AES_128_GCM_SHA256
suite_tls13_aes128 := {
	"macAlgorithm": "SHA-256",
	"sessionCipher": "AES-128-GCM",
}

# TLS 1.3: TLS_CHACHA20_POLY1305_SHA256
suite_tls13_chacha := {
	"macAlgorithm": "SHA-256",
	"sessionCipher": "CHACHA20-POLY1305",
}

# TLS 1.2: TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
suite_ecdhe_rsa_aes128 := {
	"authenticationMechanism": "RSA",
	"keyExchangeAlgorithm": "ECDHE",
	"macAlgorithm": "SHA-256",
	"sessionCipher": "AES-128-GCM",
}

# Legacy: TLS_RSA_WITH_RC4_128_SHA
suite_rc4 := {
	"authenticationMechanism": "RSA",
	"keyExchangeAlgorithm": "RSA",
	"macAlgorithm": "SHA-1",
	"sessionCipher": "RC4-128",
}

test_compliant_when_all_cipher_suites_are_allowed if {
	fixture := {"transportEncryption": {"cipherSuites": [suite_tls13_aes128, suite_tls13_chacha]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_a_weak_cipher_suite_is_also_offered if {
	# Regression test for #438
	fixture := {"transportEncryption": {"cipherSuites": [suite_tls13_aes128, suite_rc4]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_compliant_when_no_cipher_suite_is_allowed if {
	fixture := {"transportEncryption": {"cipherSuites": [suite_rc4]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_cipher_suite_is_missing if {
	fixture := {"transportEncryption": {"dhGroup": "2048"}}
	not applicable with input as fixture
}

test_not_applicable_when_cipher_suite_is_not_an_array if {
	fixture := {"transportEncryption": {"cipherSuites": suite_tls13_aes128}}
	not applicable with input as fixture
}

test_not_applicable_when_no_transport_encryption_present if {
	fixture := {"type": ["NetworkService"]}
	not applicable with input as fixture
}

test_finds_transport_encryption_at_any_nesting_level if {
	fixture := {"nic": {"transportEncryption": {"cipherSuites": [suite_ecdhe_rsa_aes128]}}}
	applicable with input as fixture
	compliant with input as fixture
}