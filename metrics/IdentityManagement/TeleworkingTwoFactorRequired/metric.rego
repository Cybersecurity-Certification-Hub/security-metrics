package cch.metrics.teleworking_two_factor_required

import data.cch.all_compliant
import data.cch.comparison_result
import input.teleworkingPolicy as teleworkingPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"twoFactorRequired" in object.keys(teleworkingPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy requires two-factor authentication for teleworking/remote access." if {
	compliant
} else := "The policy does not require two-factor authentication for teleworking/remote access." if {
	not compliant
}

results := [comparison_result("teleworkingPolicy.twoFactorRequired", teleworkingPolicy.twoFactorRequired)]
