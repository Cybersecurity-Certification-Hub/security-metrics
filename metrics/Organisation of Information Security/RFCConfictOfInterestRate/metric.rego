package cch.metrics.mt-ois-02.6h-1

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
}

compliant if {
    compare(data.operator, data.target_value, document.OrganisationofInformationSecurity.RFC.conflictOfInterestRate)
}
