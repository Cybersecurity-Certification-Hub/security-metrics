package cch.metrics.patch_management_policy_check_q2

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
    document
}

compliant if {
    compare(data.operator, data.target_value, document:PatchManagement.Procedure.vulnerabilityPriority)
}
