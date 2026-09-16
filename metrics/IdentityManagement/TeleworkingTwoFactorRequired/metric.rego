package cch.metrics.teleworking_two_factor_required

import data.cch.comparison_result
import rego.v1
import input.teleworking as teleworking

default applicable := false
default compliant := false

applicable if {
      teleworking != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("teleworking.twoFactorRequired", teleworking.twoFactorRequired)]
