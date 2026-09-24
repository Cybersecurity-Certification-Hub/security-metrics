package cch.metrics.liability_cost_assignment_explicit

import data.cch.comparison_result
import rego.v1
import input.liabilityPolicy as liabilityPolicy

default applicable := false
default compliant := false

applicable if {
	"costsExplicitlyAssignedToProvider" in object.keys(liabilityPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The clause explicitly assigns costs/responsibility to the Service Provider." if {
	compliant
} else := "The clause does not explicitly assign costs/responsibility to the Service Provider." if {
	not compliant
}

results := [comparison_result("liabilityPolicy.costsExplicitlyAssignedToProvider", liabilityPolicy.costsExplicitlyAssignedToProvider)]
