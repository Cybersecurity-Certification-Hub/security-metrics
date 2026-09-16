package cch.metrics.acceptable_use_policy_documented

import data.cch.comparison_result
import rego.v1
import input.acceptableUse as acceptableUse

default applicable := false
default compliant := false

applicable if {
      acceptableUse != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("acceptableUse.exists", acceptableUse.exists)]
