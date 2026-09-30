package cch.metrics.asset_ownership_assignment_stated

import rego.v1

test_compliant_when_ownerAssignmentStated_is_valid if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {"ownerAssignmentStated": true}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_ownerAssignmentStated_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {"ownerAssignmentStated": false}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_ownerAssignmentStated_is_missing if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "assetInventory": {"ownerAssignmentStated": true}}
	not applicable with input as fixture
}
