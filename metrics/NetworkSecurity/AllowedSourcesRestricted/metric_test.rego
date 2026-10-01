package cch.metrics.allowed_sources_restricted

import rego.v1

test_compliant_when_sources_within_allowed_cidr if {
	fixture := {"type": ["NetworkInterface"], "accessRestriction": {"l3Firewall": {"allowedSources": ["10.1.2.3", "10.5.0.0/256"]}}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_source_outside_allowed_cidrs if {
	fixture := {"type": ["NetworkInterface"], "accessRestriction": {"l3Firewall": {"allowedSources": ["8.8.8.8"]}}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_compliant_when_one_of_several_sources_is_outside_allowed_cidrs if {
	fixture := {"type": ["NetworkInterface"], "accessRestriction": {"l3Firewall": {"allowedSources": ["10.1.2.3", "8.8.8.8"]}}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_compliant_when_allowed_sources_empty if {
	fixture := {"type": ["NetworkInterface"], "accessRestriction": {"l3Firewall": {"allowedSources": []}}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_for_0_0_0_0_0 if {
	fixture := {"type": ["NetworkInterface"], "accessRestriction": {"l3Firewall": {"allowedSources": ["0.0.0.0/0"]}}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_compliant_when_vnet_not_literally_allowed if {
	fixture := {"type": ["NetworkInterface"], "accessRestriction": {"l3Firewall": {"allowedSources": ["vnet:abc"]}}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_allowed_sources_missing if {
	fixture := {"type": ["NetworkInterface"], "accessRestriction": {"l3Firewall": {}}}
	not applicable with input as fixture
}

test_not_applicable_for_other_resource_types if {
	fixture := {"type": ["BlockStorage"], "accessRestriction": {"l3Firewall": {"allowedSources": ["10.1.2.3"]}}}
	not applicable with input as fixture
}
