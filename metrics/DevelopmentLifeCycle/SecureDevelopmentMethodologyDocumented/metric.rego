package cch.metrics.secure_development_methodology_documented

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

results := [comparison_result("sdlc.referencesIndustryFramework", sdlc.referencesIndustryFramework)]
