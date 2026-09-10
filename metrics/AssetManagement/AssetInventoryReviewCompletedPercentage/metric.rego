package cch.metrics.asset_inventory_review_completed_percentage

import data.cch.comparison_result
import rego.v1

import input.assetInventory as ai

default applicable := false

default compliant := false

applicable if {
    "Account" in input.type
    ai
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("assetInventory.completedReviewPercentage", ai.completedReviewPercentage)]
