package cch.metrics.document_csaf_content_valid

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
	every r in results { r.success }
}

results := [comparison_result("schemaValidation.errors.count", count(document.schemaValidation.errors))]
