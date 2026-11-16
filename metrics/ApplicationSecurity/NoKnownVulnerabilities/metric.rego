package cch.metrics.no_known_vulnerabilities

import rego.v1
import data.cch.comparison_result

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

top_level_vulnerabilities := [v |
	v := input.vulnerabilities[_]
]

single_functionality_vulnerabilities := [v |
	some functionality in input.functionalities
	v := functionality.vulnerability
]

list_functionality_vulnerabilities := [v |
	some functionality in input.functionalities
	v := functionality.vulnerabilities[_]
]

all_vulnerabilities := array.concat(
	top_level_vulnerabilities,
	array.concat(
		single_functionality_vulnerabilities,
		list_functionality_vulnerabilities,
	),
)

# Count actual vulnerabilities. An unset singular proto field serializes as an
# empty object (`vulnerability: {}`) and must not count as a vulnerability —
# this preserves the previous semantics of `count(vul) == 0`, which covered
# empty arrays and empty objects.
vulnerability_count := count([v |
	some v in all_vulnerabilities
	v != {}
])

results := [
	comparison_result("vulnerabilities.count", vulnerability_count),
]

compliant if {
	every r in results {
		r.success
	}
}

message := "The analyzed resource has no known vulnerabilities." if {
	compliant
} else := "The analyzed resource shows evidence that it contains known vulnerabilities." if {
	not compliant
}