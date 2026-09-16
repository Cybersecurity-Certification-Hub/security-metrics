package cch.metrics.liability_cost_assignment_explicit

import data.cch.comparison_result
import rego.v1
import input.liabilityClause as liabilityClause

default applicable := false
default compliant := false

applicable if {
      liabilityClause != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("liabilityClause.costsExplicitlyAssignedToProvider", liabilityClause.costsExplicitlyAssignedToProvider)]
