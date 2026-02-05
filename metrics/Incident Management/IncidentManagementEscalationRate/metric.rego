package cch.metrics.mt-im-02.6h-3

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
}

compliant if {
    compare(data.operator, data.target_value, document.IncidentManagement.correctIncidentEscalationRate)
}
