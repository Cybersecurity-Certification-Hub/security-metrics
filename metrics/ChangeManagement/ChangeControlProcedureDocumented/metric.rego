package cch.metrics.change_control_procedure_documented

import data.cch.comparison_result
import rego.v1
import input.changeManagement as changeManagement

default applicable := false
default compliant := false

applicable if {
      changeManagement != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("changeManagement.approvalRequiredBeforeProdChange", changeManagement.approvalRequiredBeforeProdChange)]
