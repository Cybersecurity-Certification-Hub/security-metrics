package cch.metrics.number_of_failed_authentication_attempts

import data.cch.compare
import rego.v1
import input as resource

default applicable := false

default compliant := false

applicable if {
	resource.authenticationStatistics
}

compliant if {
    compare(data.operator, data.target_value, resource.authenticationStatistics.failedAuthenticationAttempts)
}
