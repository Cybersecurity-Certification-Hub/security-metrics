package cch.metrics.number_of_failed_authentication_attempts

import data.cch.compare
import rego.v1
import input.authenticity as auth

default applicable := false

default compliant := false

applicable if {
	input.type[_] == "HttpEndpoint"
	auth
}

compliant if {
    compare(data.operator, data.target_value, auth.failedAuthenticationAttempts)
}
