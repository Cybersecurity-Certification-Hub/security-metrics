package cch.metrics.strong_cryptographic_hash

import rego.v1

test_compliant_when_algorithm_is_valid if {
	fixture := {"type": ["PolicyDocument"], "cryptographicHash": {"algorithm": "SHA-256"}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_algorithm_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "cryptographicHash": {"algorithm": "MD5"}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "cryptographicHash.algorithm"
	rs[0].value == "MD5"
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

test_not_applicable_when_algorithm_is_missing if {
	fixture := {"type": ["PolicyDocument"], "cryptographicHash": {}}
	not applicable with input as fixture
}
