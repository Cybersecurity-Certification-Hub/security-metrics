package cch.metrics.security_training_cadence

import data.cch.comparison_result
import rego.v1
import input.training as training

default applicable := false
default compliant := false

applicable if {
      training != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("training.annualCadenceStated", training.annualCadenceStated)]
