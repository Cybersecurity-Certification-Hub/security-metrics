package cch.metrics.code_notebook_vulnerabilities_detected

import data.cch.comparison_result
import rego.v1

import input.vulnerabilities as vuln

default applicable = false

default compliant = false

applicable if {
	input.type[_] == "CodeNotebook"
	vuln
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("vulnerabilities.count", count(vuln))]
