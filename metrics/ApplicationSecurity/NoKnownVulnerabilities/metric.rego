package cch.metrics.no_known_vulnerabilities

import data.cch.comparison_result
import rego.v1

default applicable := false
default compliant := false

# Collect vulnerabilities from the top-level input path.
vulnerability_sources contains vul if {
    vul := input.vulnerabilities
    vul != {}
}

# Collect plural vulnerabilities from functionality objects.
vulnerability_sources contains vul if {
    some functionality in input.functionalities
    vul := functionality.vulnerabilities
    vul != {}
}

# Collect a singular vulnerability from functionality objects.
vulnerability_sources contains vul if {
    some functionality in input.functionalities
    vul := functionality.vulnerability
    vul != {}
}

# The metric is applicable if at least one vulnerability source exists.
applicable if {
    count(vulnerability_sources) > 0
}

# Create one comparison result for every discovered vulnerability source.
results := [
    comparison_result("vulnerabilities", vul) |
    some vul in vulnerability_sources
]

compliant if {
    applicable
    every r in results {
        r.success
    }
}

message := "The analyzed resource has no known vulnerabilities." if {
    compliant
} else := "The analyzed resource shows evidence that it contains known vulnerabilities." if {
    not compliant
}