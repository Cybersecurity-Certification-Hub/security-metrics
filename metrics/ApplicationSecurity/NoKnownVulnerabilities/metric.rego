package cch.metrics.no_known_vulnerabilities

import rego.v1

default applicable := false
default compliant := false

# Vulnerabilities are attached to various objects and can appear in different structures:
# as a single element, an array, or at different nesting levels (e.g., `vulnerabilities` or `code.vulnerability`).
# These checks account for these structural variations to ensure robust assessment..

# Collect the top-level vulnerabilities field if it exists.
vulnerability_sources contains vul if {
    vul := input.vulnerabilities
}

# Collect the plural vulnerabilities field from functionality objects if it exists.
vulnerability_sources contains vul if {
    some functionality in input.functionalities
    vul := functionality.vulnerabilities
}

# Collect the singular vulnerability field from functionality objects if it exists.
vulnerability_sources contains vul if {
    some functionality in input.functionalities
    vul := functionality.vulnerability
}

# The metric is applicable when at least one supported field exists.
applicable if {
    count(vulnerability_sources) > 0
}

# The resource is compliant only when all found vulnerability fields are empty (no entries).
# A field may serialize as an empty array `[]` (repeated proto field, the common case)
# or as an empty object `{}`; `count(vul) == 0` covers both, whereas `vul == {}`
# only matched the empty-object shape and falsely flagged empty arrays as non-compliant.
compliant if {
	applicable
    every vul in vulnerability_sources {
        count(vul) == 0
    }
}

message := "The analyzed resource has no known vulnerabilities." if {
    compliant
} else := "The analyzed resource shows evidence that it contains known vulnerabilities." if {
    not compliant
}