package cch.metrics.tls_cipher_suite

import data.cch.comparison_result
import rego.v1

default applicable := false
default compliant := false

# Finds transportEncryption directly under input or at any nesting level.
transport_encryptions contains enc if {
	walk(input, [path, enc])
	count(path) > 0
	path[count(path) - 1] == "transportEncryption"
	is_object(enc)
}

# Collects all discovered cipherSuites arrays.
cipher_suite_arrays := [
enc.cipherSuites |
	some enc in transport_encryptions
	is_array(enc.cipherSuites)
]

applicable if {
	count(cipher_suite_arrays) > 0
}

compliant if {
	# At least one cipherSuites array must exist.
	count(results) > 0

	# Empty cipherSuites arrays are not compliant.
	every cipher_suites in cipher_suite_arrays {
		count(cipher_suites) > 0
	}

	# Every generated comparison result must be successful.
	every result in results {
		result.success
	}
}

# Creates one comparison result for every discovered cipherSuites array.
results := [
comparison_result(
	"transportEncryption.cipherSuites",
	normalize_cipher_suites(cipher_suites),
) |
	some cipher_suites in cipher_suite_arrays
]

# Converts all cipher-suite objects in an array into TLS names.
normalize_cipher_suites(cipher_suites) := [
cipher_suite_name(cipher_suite) |
	some cipher_suite in cipher_suites
]

# normalize_component normalizes algorithm names for TLS cipher suites.
#
# Examples:
# AES-128-GCM -> AES_128_GCM
# SHA-256     -> SHA256
normalize_component(value) := normalized if {
	is_string(value)

	uppercase := upper(value)
	with_underscores := replace(uppercase, "-", "_")
	normalized := replace(with_underscores, "SHA_", "SHA")
}

# Extracts and normalizes all components of a cipher-suite object.
cipher_suite_components(cipher_suite) := components if {
	is_object(cipher_suite)

	components := {
		"mac": normalize_component(object.get(cipher_suite, "macAlgorithm", "")),
		"authentication": normalize_component(object.get(cipher_suite, "authenticationMechanism", "")),
		"session_cipher": normalize_component(object.get(cipher_suite, "sessionCipher", "")),
		"key_exchange": normalize_component(object.get(cipher_suite, "keyExchangeAlgorithm", "")),
	}
}

# Removes empty values from an array.
non_empty(values) := [
value |
	some value in values
	value != ""
]

# Converts a TLS 1.2 cipher-suite object into its standard name.
#
# Format:
# TLS_<key exchange>_<authentication>_WITH_<cipher>_<MAC>
#
# Example:
# TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
cipher_suite_name(cipher_suite) := name if {
	components := cipher_suite_components(cipher_suite)

	components.key_exchange != ""
	components.authentication != ""
	components.session_cipher != ""
	components.mac != ""

	name := sprintf(
		"TLS_%s_%s_WITH_%s_%s",
		[
			components.key_exchange,
			components.authentication,
			components.session_cipher,
			components.mac,
		],
	)
}

# Converts a TLS 1.3 cipher-suite object into its standard name.
#
# Format:
# TLS_<cipher>_<hash>
#
# Examples:
# TLS_AES_128_GCM_SHA256
# TLS_CHACHA20_POLY1305
cipher_suite_name(cipher_suite) := name if {
	components := cipher_suite_components(cipher_suite)

	components.key_exchange == ""
	components.authentication == ""
	components.session_cipher != ""

	name_components := non_empty([
		components.session_cipher,
		components.mac,
	])

	name := sprintf(
		"TLS_%s",
		[concat("_", name_components)],
	)
}

# Ensures that incomplete or unsupported cipher suites fail the comparison
# instead of being silently ignored.
cipher_suite_name(cipher_suite) := name if {
	not valid_cipher_suite(cipher_suite)

	name := sprintf(
		"__UNRECOGNIZED_CIPHER_SUITE__:%v",
		[cipher_suite],
	)
}

# A cipher-suite object is valid if it can be represented as either
# a TLS 1.2 or TLS 1.3 cipher-suite name.
valid_cipher_suite(cipher_suite) if {
	components := cipher_suite_components(cipher_suite)

	components.key_exchange != ""
	components.authentication != ""
	components.session_cipher != ""
	components.mac != ""
}

valid_cipher_suite(cipher_suite) if {
	components := cipher_suite_components(cipher_suite)

	components.key_exchange == ""
	components.authentication == ""
	components.session_cipher != ""
}