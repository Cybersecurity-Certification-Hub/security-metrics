package cch.metrics.device_checklist_coverage

import data.cch.comparison_result
import rego.v1
import input.deviceManagement as deviceManagement

default applicable := false
default compliant := false

applicable if {
      deviceManagement != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("deviceManagement.checklistCoveragePercent", deviceManagement.checklistCoveragePercent)]
