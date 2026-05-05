package cch.metrics.asset_inventory_review_completed_percentage

import data.cch.compare
import rego.v1

import input.assetManagement as am

default applicable := false

default compliant := false

applicable if {
    am
}

compliant if {
    compare(data.operator, data.target_value, am.completedReviewPercentage)
}
