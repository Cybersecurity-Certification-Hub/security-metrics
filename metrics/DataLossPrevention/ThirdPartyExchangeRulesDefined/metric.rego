package cch.metrics.third_party_exchange_rules_defined

import data.cch.comparison_result
import rego.v1
import input.dataConfidentialitySDNPolicy as dataConfidentialitySDNPolicy

default applicable := false
default compliant := false

applicable if {
	"thirdPartyExchangeRulesDefined" in object.keys(dataConfidentialitySDNPolicy)
	is_boolean(dataConfidentialitySDNPolicy.thirdPartyExchangeRulesDefined)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy specifically defines rules for information exchange with third parties." if {
	compliant
} else := "The policy does not specifically define rules for information exchange with third parties." if {
	not compliant
}

results := [comparison_result("dataConfidentialitySDNPolicy.thirdPartyExchangeRulesDefined", dataConfidentialitySDNPolicy.thirdPartyExchangeRulesDefined)]
