package cch.metrics.crypto_filename_restricted

import data.cch.comparison_result
import rego.v1
import input.cryptoPolicy as cryptoPolicy

default applicable := false
default compliant := false

applicable if {
      cryptoPolicy != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("cryptoPolicy.nonDescriptiveFilenameRequired", cryptoPolicy.nonDescriptiveFilenameRequired)]
