package cch.metrics.tls_cipher_suite

import data.cch.comparison_result
import rego.v1

default applicable := false
default compliant := false

# Finds all transportEncryption objects at any nesting level.
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
	# At least one comparison result must exist.
	count(results) > 0

	# Empty cipherSuites arrays are not compliant.
	every cipher_suites in cipher_suite_arrays {
		count(cipher_suites) > 0
	}

	# Every comparison result must be successful.
	every result in results {
		result.success
	}
}

# Stores normalized components for each cipher suite.
#
# The key consists of:
# <cipherSuites array index>:<cipher suite index>
#
# Example: "0:2"
cipher_suite_components[key] := components if {
	some array_index, cipher_suites in cipher_suite_arrays
	some suite_index, cipher_suite in cipher_suites

	key := sprintf("%d:%d", [array_index, suite_index])

	is_object(cipher_suite)

	mac_raw := object.get(
		cipher_suite,
		"macAlgorithm",
		"",
	)
	authentication_raw := object.get(
		cipher_suite,
		"authenticationMechanism",
		"",
	)
	session_cipher_raw := object.get(
		cipher_suite,
		"sessionCipher",
		"",
	)
	key_exchange_raw := object.get(
		cipher_suite,
		"keyExchangeAlgorithm",
		"",
	)

	is_string(mac_raw)
	is_string(authentication_raw)
	is_string(session_cipher_raw)
	is_string(key_exchange_raw)

	components := {
		"mac": replace(
			replace(upper(mac_raw), "-", "_"),
			"SHA_",
			"SHA",
		),
		"authentication": replace(
			replace(upper(authentication_raw), "-", "_"),
			"SHA_",
			"SHA",
		),
		"session_cipher": replace(
			replace(upper(session_cipher_raw), "-", "_"),
			"SHA_",
			"SHA",
		),
		"key_exchange": replace(
			replace(upper(key_exchange_raw), "-", "_"),
			"SHA_",
			"SHA",
		),
	}
}

# Creates names for valid TLS 1.2 cipher suites.
tls12_cipher_suite_names[key] := name if {
	components := cipher_suite_components[key]

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

# Creates names for valid TLS 1.3 cipher suites.
tls13_cipher_suite_names[key] := name if {
	components := cipher_suite_components[key]

	components.key_exchange == ""
	components.authentication == ""
	components.session_cipher != ""

	name_components := [
		component |
		some component in [
			components.session_cipher,
			components.mac,
		]
		component != ""
	]

	name := sprintf(
		"TLS_%s",
		[concat("_", name_components)],
	)
}

# Creates a normalized TLS-name array for each original
# cipherSuites array.
normalized_cipher_suite_arrays := [
	normalized_cipher_suites |
	some array_index, cipher_suites in cipher_suite_arrays

	normalized_cipher_suites := [
		name |
		some suite_index, cipher_suite in cipher_suites

		key := sprintf(
			"%d:%d",
			[array_index, suite_index],
		)

		# Invalid or unsupported cipher suites must fail the
		# comparison instead of being silently ignored.
		fallback := sprintf(
			"__UNRECOGNIZED_CIPHER_SUITE__:%v",
			[cipher_suite],
		)

		# Prefer a TLS 1.3 name over the fallback value.
		tls13_or_fallback := object.get(
			tls13_cipher_suite_names,
			key,
			fallback,
		)

		# Prefer a TLS 1.2 name over the TLS 1.3 or fallback value.
		name := object.get(
			tls12_cipher_suite_names,
			key,
			tls13_or_fallback,
		)
	]
]

# Creates one comparison result for each discovered cipherSuites array.
results := [
	comparison_result(
		"transportEncryption.cipherSuites",
		normalized_cipher_suites,
	) |
	some normalized_cipher_suites in normalized_cipher_suite_arrays
]