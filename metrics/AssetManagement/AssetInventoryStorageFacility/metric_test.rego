package cch.metrics.asset_inventory_storage_facility

import rego.v1

test_compliant_when_storageFacility_is_valid if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {"storageFacility": ["central", "distributed"]}}
	applicable with input as fixture
	compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].success
}

test_not_compliant_has_details_when_storageFacility_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {"storageFacility": ["central", "on paper"]}}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].property == "assetInventory.storageFacility"
	rs[0].value == ["central", "on paper"]
	rs[0].target_value == data.target_value
	rs[0].operator == data.operator
	rs[0].success == false
}

test_not_applicable_when_storageFacility_is_missing if {
	fixture := {"type": ["PolicyDocument"], "assetInventory": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "assetInventory": {"storageFacility": ["central", "distributed"]}}
	not applicable with input as fixture
}
