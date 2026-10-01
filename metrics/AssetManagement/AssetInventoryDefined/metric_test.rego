package cch.metrics.asset_inventory_defined

import rego.v1

test_compliant_when_inventoryDefined_is_valid if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {"inventoryDefined": ["Asset Inventory"]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_inventoryDefined_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {"inventoryDefined": ["not an accepted answer"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_inventoryDefined_is_missing if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "assetInventory": {"inventoryDefined": ["Asset Inventory"]}}
	not applicable with input as fixture
}
