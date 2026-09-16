package cch.metrics.anonymization_technique_named

import data.cch.comparison_result
import rego.v1
import input.testData as testData

default applicable := false
default compliant := false

applicable if {
      testData != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("testData.technique", testData.technique)]
