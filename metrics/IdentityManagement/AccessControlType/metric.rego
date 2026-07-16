package cch.metrics.access_control_type

import data.cch.compare
import rego.v1
import input.accessControlTypePolicy as accessControlTypePolicy

default applicable := false

default compliant := false

applicable if {
    accessControlTypePolicy != {}
    "PolicyDocument" in input.type
}

compliant if {
    compare(data.operator, data.target_value, accessControlTypePolicy.authorizationTypes)
}

message := "The access control type is appropriately configured with one of the approved types (RBAC, DAC, or MAC)." if {
    compliant
} else := "The access control type is not configured with one of the approved types (RBAC, DAC, or MAC)." if {
    not compliant
}
