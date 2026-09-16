package cch.metrics.sdlc_checklist_coverage

import data.cch.comparison_result
import rego.v1
import input.sdlc as sdlc

default applicable := false
default compliant := false

applicable if {
      sdlc != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("sdlc.checklistCoveragePercent", sdlc.checklistCoveragePercent)]
