package cch.metrics.asset_inventory_review_completed_percentage

import data.cch.compare
import rego.v1

import input.assetInventory as ai

default applicable := false

default compliant := false

applicable if {
    ai
}

compliant if {
    compare(data.operator, data.target_value, ai.completedReviewPercentage)
}
