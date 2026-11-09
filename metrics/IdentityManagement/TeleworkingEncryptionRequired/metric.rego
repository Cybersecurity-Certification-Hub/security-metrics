package cch.metrics.teleworking_encryption_required

import data.cch.all_compliant
import data.cch.comparison_result
import input.teleworkingPolicy as teleworkingPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"encryptionRequired" in object.keys(teleworkingPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy requires data encryption for teleworking/remote access sessions." if {
	compliant
} else := "The policy does not require data encryption for teleworking/remote access sessions." if {
	not compliant
}

results := [comparison_result("teleworkingPolicy.encryptionRequired", teleworkingPolicy.encryptionRequired)]
