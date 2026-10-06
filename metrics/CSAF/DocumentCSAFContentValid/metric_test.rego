package cch.metrics.document_csaf_content_valid

import rego.v1

# protojson omits empty repeated fields, so a valid document has no errors key
test_compliant_when_errors_are_missing if {
	fixture := {"type": ["SecurityAdvisoryDocument"], "schemaValidation": {}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].value == 0
	rs[0].success
}

test_not_compliant_has_details_when_errors_are_present if {
	fixture := {"type": ["SecurityAdvisoryDocument"], "schemaValidation": {"errors": [{"message": "invalid"}]}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "schemaValidation.errors.count"
	rs[0].value == 1
	rs[0].success == false
}

test_not_applicable_when_schema_validation_is_missing if {
	fixture := {"type": ["SecurityAdvisoryDocument"]}
	not applicable with input as fixture
}
