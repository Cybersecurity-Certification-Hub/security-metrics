package cch.metrics.digital_cert_policy03

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    document
}

compliant if {
    compare(data.operator, data.target_value, document:DigitalCertificate.validityInterval)
}
