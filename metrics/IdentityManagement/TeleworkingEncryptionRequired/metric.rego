package cch.metrics.teleworking_encryption_required

import data.cch.comparison_result
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.teleworking
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("teleworking.encryptionRequired", document.teleworking.encryptionRequired)]
