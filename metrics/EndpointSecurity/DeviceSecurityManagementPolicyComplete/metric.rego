package cch.metrics.device_security_management_policy_complete

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

results := [comparison_result("deviceManagement.allMandatedControlsAddressed", deviceManagement.allMandatedControlsAddressed)]
