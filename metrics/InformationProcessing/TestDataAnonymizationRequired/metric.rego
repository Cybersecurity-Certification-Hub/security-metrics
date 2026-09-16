package cch.metrics.test_data_anonymization_required

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

results := [comparison_result("testData.anonymizationRequiredForNonProd", testData.anonymizationRequiredForNonProd)]
