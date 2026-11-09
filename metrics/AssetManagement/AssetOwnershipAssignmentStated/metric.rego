package cch.metrics.asset_ownership_assignment_stated

import data.cch.all_compliant
import data.cch.comparison_result
import input.assetInventory as assetInventory
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"ownerAssignmentStated" in object.keys(assetInventory)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "An owner is assigned for each asset class/type." if {
	compliant
} else := "An owner is not assigned for each asset class/type." if {
	not compliant
}

results := [comparison_result("assetInventory.ownerAssignmentStated", assetInventory.ownerAssignmentStated)]
