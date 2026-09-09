package cch.metrics.anonymization_technique_named

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.testData
}

compliant if {
	compare(data.operator, data.target_value, document.testData.technique)
}
