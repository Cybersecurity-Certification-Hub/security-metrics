package cch.metrics.encrypted_transfer_channel_required

import data.cch.comparison_result
import rego.v1
import input.cryptographicTransferPolicy as cryptographicTransferPolicy

default applicable := false
default compliant := false

applicable if {
	"encryptedChannelRequired" in object.keys(cryptographicTransferPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy requires encrypted channels for data transmission and reception." if {
	compliant
} else := "The policy does not require encrypted channels for data transmission and reception." if {
	not compliant
}

results := [comparison_result("cryptographicTransferPolicy.encryptedChannelRequired", cryptographicTransferPolicy.encryptedChannelRequired)]
