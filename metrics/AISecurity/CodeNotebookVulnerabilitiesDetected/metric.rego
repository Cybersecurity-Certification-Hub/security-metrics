package cch.metrics.code_notebook_vulnerabilities_detected

import data.cch.compare
import rego.v1

import input.CodeNotebook.Vulnerabilities as vuln

default applicable = false

default compliant = false

applicable if {
	vuln
}

compliant if {
	compare(data.operator, data.target_value, count(vuln))
}
