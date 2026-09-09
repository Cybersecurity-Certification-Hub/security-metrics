package cch.metrics.code_notebook_vulnerabilities_detected

import data.cch.compare
import data.cch.comparison_result
import rego.v1

import input.Vulnerabilities as vuln

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "CodeNotebook"
	vuln
}

compliant if {
	compare(data.operator, data.target_value, count(vuln))
}

results := [comparison_result("Vulnerabilities.count", count(vuln))]
