package cch.metrics.teleworking_two_factor_required

import data.cch.comparison_result
import rego.v1
import input.teleworkingPolicy as teleworkingPolicy

default applicable := false
default compliant := false

applicable if {
	"twoFactorRequired" in object.keys(teleworkingPolicy)
	is_boolean(teleworkingPolicy.twoFactorRequired)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy requires two-factor authentication for teleworking/remote access." if {
	compliant
} else := "The policy does not require two-factor authentication for teleworking/remote access." if {
	not compliant
}

results := [comparison_result("teleworkingPolicy.twoFactorRequired", teleworkingPolicy.twoFactorRequired)]
