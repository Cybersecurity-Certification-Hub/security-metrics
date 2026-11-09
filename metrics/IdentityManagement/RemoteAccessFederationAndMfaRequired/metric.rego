package cch.metrics.remote_access_federation_and_mfa_required

import data.cch.all_compliant
import data.cch.comparison_result
import input.teleworkingPolicy as teleworkingPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"mfaAndFederationRequiredForRemoteAccess" in object.keys(teleworkingPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The procedure requires MFA and federation for remote/teleworking/VPN access." if {
	compliant
} else := "The procedure does not require MFA and federation for remote/teleworking/VPN access." if {
	not compliant
}

results := [comparison_result("teleworkingPolicy.mfaAndFederationRequiredForRemoteAccess", teleworkingPolicy.mfaAndFederationRequiredForRemoteAccess)]
