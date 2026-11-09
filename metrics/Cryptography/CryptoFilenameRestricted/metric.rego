package cch.metrics.crypto_filename_restricted

import data.cch.all_compliant
import data.cch.comparison_result
import input.cryptographicTransferPolicy as cryptographicTransferPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"nonDescriptiveFilenameRequired" in object.keys(cryptographicTransferPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "Transferred file names must not include descriptive content." if {
	compliant
} else := "Transferred file names are not required to exclude descriptive content." if {
	not compliant
}

results := [comparison_result("cryptographicTransferPolicy.nonDescriptiveFilenameRequired", cryptographicTransferPolicy.nonDescriptiveFilenameRequired)]
