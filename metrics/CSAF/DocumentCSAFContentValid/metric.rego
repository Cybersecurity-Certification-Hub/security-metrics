package cch.metrics.document_csaf_content_valid

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	# check resource type
	"SecurityAdvisoryDocument" in document.type
}

compliant if {
	# Check if errors are available
	# If no errors exist, the document is valid
	compare(data.operator, data.target_value, count(document.schemaValidation.errors))
}

results := [comparison_result("schemaValidation.errors.count", count(document.schemaValidation.errors))]
