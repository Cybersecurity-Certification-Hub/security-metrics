package cch.metrics.document_csaf_content_valid

import data.cch.all_compliant
import data.cch.comparison_result
import input as document
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"schemaValidation" in object.keys(document)

	# check resource type
	"SecurityAdvisoryDocument" in document.type
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("schemaValidation.errors.count", count(object.get(document.schemaValidation, "errors", [])))]
