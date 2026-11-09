package cch.metrics.encrypted_transfer_channel_required

import data.cch.all_compliant
import data.cch.comparison_result
import input.cryptographicTransferPolicy as cryptographicTransferPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"encryptedChannelRequired" in object.keys(cryptographicTransferPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy requires encrypted channels for data transmission and reception." if {
	compliant
} else := "The policy does not require encrypted channels for data transmission and reception." if {
	not compliant
}

results := [comparison_result("cryptographicTransferPolicy.encryptedChannelRequired", cryptographicTransferPolicy.encryptedChannelRequired)]
