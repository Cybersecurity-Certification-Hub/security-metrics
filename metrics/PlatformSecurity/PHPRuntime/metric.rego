package cch.metrics.php_runtime

import data.cch.comparison_result
import rego.v1
import input as func

default applicable = false

default compliant = false

applicable if {
	func.runtimeLanguage == "PHP"
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("runtimeVersion", func.runtimeVersion)]
