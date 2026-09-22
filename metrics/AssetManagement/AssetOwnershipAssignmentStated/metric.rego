package cch.metrics.asset_ownership_assignment_stated

import data.cch.comparison_result
import rego.v1
import input.assetInventory as assetInventory

default applicable := false
default compliant := false

applicable if {
	"ownerAssignmentStated" in object.keys(assetInventory)
	is_boolean(assetInventory.ownerAssignmentStated)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "An owner is assigned for each asset class/type." if {
	compliant
} else := "An owner is not assigned for each asset class/type." if {
	not compliant
}

results := [comparison_result("assetInventory.ownerAssignmentStated", assetInventory.ownerAssignmentStated)]
