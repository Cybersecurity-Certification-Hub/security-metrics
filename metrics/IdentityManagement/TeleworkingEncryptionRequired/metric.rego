package cch.metrics.teleworking_encryption_required

import data.cch.comparison_result
import rego.v1
import input.teleworking

default applicable := false

default compliant := false

applicable if {
	"PolicyDocument" in input.type
	tw
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("teleworking.encryptionRequired",teleworking.encryptionRequired)]
