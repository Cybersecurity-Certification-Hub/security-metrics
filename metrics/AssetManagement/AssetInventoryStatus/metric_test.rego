package cch.metrics.asset_inventory_status

import rego.v1

test_compliant_when_status_is_valid if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {"status": ["active", "lost"]}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_status_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {"status": ["active", "stolen"]}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "assetInventory.status"
	rs[0].value == ["active", "stolen"]
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

test_not_applicable_when_status_is_missing if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "assetInventory": {"status": ["active", "lost"]}}
	not applicable with input as fixture
}
