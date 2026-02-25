package cch.metrics.wildcardCertificateInterval

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    # TODO: Add ontolgy terms "isWildcard" and "intervalMonths"
    compare("==", true, document.certificateBasedAuthentication.isWildcard)
    compare(data.operator, data.target_value, document.certificateBasedAuthentication.intervalMonths)
}
