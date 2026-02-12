package cch.metrics.certificateIssuer

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    "PolicyDocument" in document.type
}

compliant if {
    # TODO: For the ontology, I want these possible values: "public CA", "private CA" or "self-signed"
    compare(data.operator, data.target_value, document.certificateBasedAuthentication.type)
}
