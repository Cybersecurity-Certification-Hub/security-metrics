package cch.metrics.third_party_exchange_rules_defined

import data.cch.comparison_result
import rego.v1
import input.dlp as dlp

default applicable := false
default compliant := false

applicable if {
      dlp != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("dlp.thirdPartyExchangeRulesDefined", dlp.thirdPartyExchangeRulesDefined)]
