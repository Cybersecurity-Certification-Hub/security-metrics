package cch.metrics.remote_access_federation_and_mfa_required

import data.cch.comparison_result
import rego.v1
import input.teleworkingPolicy as teleworkingPolicy

default applicable := false
default compliant := false

applicable if {
	"mfaAndFederationRequiredForRemoteAccess" in object.keys(teleworkingPolicy)
	is_boolean(teleworkingPolicy.mfaAndFederationRequiredForRemoteAccess)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The procedure requires MFA and federation for remote/teleworking/VPN access." if {
	compliant
} else := "The procedure does not require MFA and federation for remote/teleworking/VPN access." if {
	not compliant
}

results := [comparison_result("teleworkingPolicy.mfaAndFederationRequiredForRemoteAccess", teleworkingPolicy.mfaAndFederationRequiredForRemoteAccess)]
