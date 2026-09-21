package cch.metrics.crypto_key_recipient_held

import data.cch.comparison_result
import rego.v1
import input.cryptographicTransferPolicy as cryptographicTransferPolicy

default applicable := false
default compliant := false

applicable if {
	"recipientHeldKeyRequired" in object.keys(cryptographicTransferPolicy)
	is_boolean(cryptographicTransferPolicy.recipientHeldKeyRequired)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The encryption key used to protect the file must be held by the recipient." if {
	compliant
} else := "The encryption key used to protect the file is not required to be held by the recipient." if {
	not compliant
}

results := [comparison_result("cryptographicTransferPolicy.recipientHeldKeyRequired", cryptographicTransferPolicy.recipientHeldKeyRequired)]
