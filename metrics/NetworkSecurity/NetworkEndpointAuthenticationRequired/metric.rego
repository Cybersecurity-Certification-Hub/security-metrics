package cch.metrics.network_endpoint_authentication_required

import data.cch.compare
import rego.v1
import input.authenticity as auth

default applicable = false

default compliant = false

applicable if {
	auth
}

auth_no_authentication := true if {
	auth.noAuthentication
} else := true if {
	auth.no_authentication
} else := false

compliant if {
	compare(data.operator, data.target_value, auth_no_authentication)
}

message := "Authentication is required for the network endpoint." if {
	compliant
} else := "The network endpoint allows unauthenticated access." if {
	not compliant
}
