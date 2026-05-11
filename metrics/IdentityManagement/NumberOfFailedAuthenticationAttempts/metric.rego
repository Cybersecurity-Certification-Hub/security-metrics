package cch.metrics.number_of_failed_authentication_attempts

import data.cch.compare
import rego.v1
import input.authenticationStatistics as as

default applicable := false

default compliant := false

applicable if {
	as
}

compliant if {
    compare(data.operator, data.target_value, as.failedAuthenticationAttempts)
}
