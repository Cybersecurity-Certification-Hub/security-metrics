package cch.metrics.no_known_vulnerabilities

import data.cch.comparison_result
import input.vulnerabilities as vul
import rego.v1

default compliant = false

default applicable = false

applicable if {
	vul != {}
	vul != null
}

compliant if {
	every r in results { r.success }
}

message := "The anaylzed resource has no known vulnerabilities." if {
	compliant
} else := "The anaylzed resource shows evidence that it contains known vulnerabilities." if {
	not compliant
}

results := [comparison_result("vulnerabilities", vul)]
