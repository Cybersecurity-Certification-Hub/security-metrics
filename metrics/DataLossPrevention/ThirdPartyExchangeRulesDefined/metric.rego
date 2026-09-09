package cch.metrics.third_party_exchange_rules_defined

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.dlp
}

compliant if {
	compare(data.operator, data.target_value, document.dlp.thirdPartyExchangeRulesDefined)
}
