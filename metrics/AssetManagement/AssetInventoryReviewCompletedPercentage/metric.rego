package cch.metrics.asset_inventory_review_completed_percentage

import data.cch.comparison_result
import rego.v1

import input.assetInventory as assetInventory

default applicable := false

default compliant := false

applicable if {
   "completedReviewPercentage" in object.keys(input.assetInventory)
    "Account" in input.type
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("assetInventory.completedReviewPercentage",assetInventory.completedReviewPercentage)]
