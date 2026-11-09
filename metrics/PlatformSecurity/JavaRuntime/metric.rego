package cch.metrics.java_runtime

import data.cch.all_compliant
import data.cch.comparison_result
import input as func
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"runtimeVersion" in object.keys(func)
	func.runtimeLanguage == "Java"
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("runtimeVersion", func.runtimeVersion)]
