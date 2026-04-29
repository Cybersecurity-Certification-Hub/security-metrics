package cch.metrics.asset_inventory_review_completed_percentage

import data.cch.compare
import rego.v1
import input as asset_management

default applicable := false

default compliant := false

applicable if {
    "AssetManagement" in asset_management.type
    asset_management.completedReviewPercentage
}

compliant if {
    compare(data.operator, data.target_value, asset_management.completedReviewPercentage)
}
