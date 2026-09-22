package cch.metrics.no_known_vulnerabilities

import rego.v1

default applicable := false
default compliant := false

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
# This matches the JSON example you provided.
vulnerability_sources contains vul if {
    some functionality in input.functionalities
    vul := functionality.vulnerability
}

# The metric is applicable when at least one supported field exists.
applicable if {
    count(vulnerability_sources) > 0
}

# The resource is compliant only when all found fields are empty objects.
compliant if {
    applicable

    every vul in vulnerability_sources {
        vul == {}
    }
}

message := "The analyzed resource has no known vulnerabilities." if {
    compliant
} else := "The analyzed resource shows evidence that it contains known vulnerabilities." if {
    not compliant
}