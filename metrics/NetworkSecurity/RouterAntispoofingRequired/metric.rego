package cch.metrics.router_antispoofing_required

import data.cch.comparison_result
import rego.v1
import input.networkStandard as networkStandard

default applicable := false
default compliant := false

applicable if {
      networkStandard != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("networkStandard.antispoofingRequired", networkStandard.antispoofingRequired)]
