package cch.metrics.crypto_filename_restricted

import data.cch.comparison_result
import rego.v1
import input.cryptographicTransferPolicy as cryptographicTransferPolicy

default applicable := false
default compliant := false

applicable if {
	"nonDescriptiveFilenameRequired" in object.keys(cryptographicTransferPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "Transferred file names must not include descriptive content." if {
	compliant
} else := "Transferred file names are not required to exclude descriptive content." if {
	not compliant
}

results := [comparison_result("cryptographicTransferPolicy.nonDescriptiveFilenameRequired", cryptographicTransferPolicy.nonDescriptiveFilenameRequired)]
