package cch.metrics.no_known_vulnerabilities

import rego.v1

# The `vulnerabilities` field on ontology resources (e.g. MachineLearningModel) is a
# `repeated Vulnerability`, so an unset/empty field serializes as an empty array `[]`,
# not an empty object `{}`. The metric must treat an empty array as compliant.

test_not_applicable_when_no_vulnerability_field if {
	fixture := {"type": ["Resource"]}
	not applicable with input as fixture
}

test_compliant_when_vulnerabilities_is_empty_array if {
	fixture := {"type": ["Resource"], "vulnerabilities": []}
	applicable with input as fixture
	compliant with input as fixture
}

test_compliant_when_vulnerabilities_is_empty_object if {
	fixture := {"type": ["Resource"], "vulnerabilities": {}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_vulnerabilities_are_present if {
	fixture := {"type": ["Resource"], "vulnerabilities": [{"id": "v1"}]}
	applicable with input as fixture
	not compliant with input as fixture
}

test_compliant_when_functionality_vulnerabilities_is_empty if {
	fixture := {"type": ["Resource"], "functionalities": [{"vulnerabilities": []}]}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_functionality_vulnerability_is_present if {
	fixture := {"type": ["Resource"], "functionalities": [{"vulnerability": {"id": "v1"}}]}
	applicable with input as fixture
	not compliant with input as fixture
}
