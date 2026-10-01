package cch.metrics.third_party_exchange_rules_defined

import rego.v1

test_compliant_when_thirdPartyExchangeRulesDefined_is_valid if {
	fixture := {"type": ["PolicyDocument"], "dataConfidentialitySdnPolicy": {"thirdPartyExchangeRulesDefined": ["third parties"]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_thirdPartyExchangeRulesDefined_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "dataConfidentialitySdnPolicy": {"thirdPartyExchangeRulesDefined": ["not an accepted answer"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_thirdPartyExchangeRulesDefined_is_missing if {
	fixture := {"type": ["PolicyDocument"], "dataConfidentialitySdnPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "dataConfidentialitySdnPolicy": {"thirdPartyExchangeRulesDefined": ["third parties"]}}
	not applicable with input as fixture
}
