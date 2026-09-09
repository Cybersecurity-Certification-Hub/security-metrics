package cch.metrics.php_runtime

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input as func

default applicable = false

default compliant = false

applicable if {
	func.runtimeLanguage == "PHP"
}

compliant if {
	compare(data.operator, data.target_value, func.runtimeVersion)
}

results := [comparison_result("runtimeVersion", func.runtimeVersion)]
