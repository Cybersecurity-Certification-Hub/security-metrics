package cch.metrics.<Metric ID in snake_case>

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
}

compliant if {
    every r in results { r.success }
}

results := [comparison_result(<Enter the full property path here>, <Enter the variable to be checked here>)]
