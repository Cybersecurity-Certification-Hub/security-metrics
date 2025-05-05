package cch.metrics.machine_learning_model_vulnerabilities_detected

import data.cch.compare
import rego.v1

import input.MachineLearningModel.Vulnerabilities as vuln

default applicable = false

default compliant = false

applicable if {
	vuln
}

compliant if {
	compare(data.operator, data.target_value, count(vuln))
}
