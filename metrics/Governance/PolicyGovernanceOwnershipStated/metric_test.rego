package cch.metrics.policy_governance_ownership_stated

import rego.v1

test_compliant_when_ownerAndApprovalDefined_is_valid if {
	fixture := {"type": ["PolicyDocument"], "securityPolicyReview": {"ownerAndApprovalDefined": true}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_ownerAndApprovalDefined_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "securityPolicyReview": {"ownerAndApprovalDefined": false}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_ownerAndApprovalDefined_is_missing if {
	fixture := {"type": ["PolicyDocument"], "securityPolicyReview": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "securityPolicyReview": {"ownerAndApprovalDefined": true}}
	not applicable with input as fixture
}
