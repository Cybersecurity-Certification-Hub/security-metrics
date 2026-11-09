package cch.metrics.crypto_key_recipient_held

import data.cch.all_compliant
import data.cch.comparison_result
import input.cryptographicTransferPolicy as cryptographicTransferPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"recipientHeldKeyRequired" in object.keys(cryptographicTransferPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The encryption key used to protect the file must be held by the recipient." if {
	compliant
} else := "The encryption key used to protect the file is not required to be held by the recipient." if {
	not compliant
}

results := [comparison_result("cryptographicTransferPolicy.recipientHeldKeyRequired", cryptographicTransferPolicy.recipientHeldKeyRequired)]
