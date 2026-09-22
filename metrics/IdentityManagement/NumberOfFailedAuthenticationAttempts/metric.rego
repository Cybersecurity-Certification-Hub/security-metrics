package cch.metrics.number_of_failed_authentication_attempts

import data.cch.comparison_result
import rego.v1

default applicable := false
default compliant := false

# Finds numeric failedAuthenticationAttempts values below an authenticity object
# at any nesting level.
failed_authentication_attempts := [
	attempt |
	walk(input, [path, attempt])
	count(path) > 0
	path[count(path) - 1] == "failedAuthenticationAttempts"
	"authenticity" in path
	is_number(attempt)
]

# The metric is applicable when at least one matching value exists.
applicable if {
	count(failed_authentication_attempts) > 0
}

# Creates one comparison result for every discovered value.
results := [
	comparison_result("authenticity.failedAuthenticationAttempts", attempt) |
	some attempt in failed_authentication_attempts
]

compliant if {
	applicable
	count(results) > 0

	# All discovered values must satisfy the comparison.
	every result in results {
		result.success
	}
}