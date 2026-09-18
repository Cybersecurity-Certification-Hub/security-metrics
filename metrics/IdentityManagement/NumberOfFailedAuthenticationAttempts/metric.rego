package cch.metrics.number_of_failed_authentication_attempts

import data.cch.comparison_result
import rego.v1
import input.authenticity as auth

default applicable := false

default compliant := false

applicable if {
	input.type[_] == "HttpEndpoint"
	 "failedAuthenticationAttempts" in object.keys(input.authenticity)
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("authenticity.failedAuthenticationAttempts", auth.failedAuthenticationAttempts)]
