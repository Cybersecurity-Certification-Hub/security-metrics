package cch.metrics.crypto_key_recipient_held

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.cryptoPolicy
}

compliant if {
	compare(data.operator, data.target_value, document.cryptoPolicy.recipientHeldKeyRequired)
}
