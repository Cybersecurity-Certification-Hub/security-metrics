package cch.metrics.remote_access_federation_and_mfa_required

import rego.v1

test_compliant_when_mfaAndFederationRequiredForRemoteAccess_is_valid if {
	fixture := {"type": ["PolicyDocument"], "teleworkingPolicy": {"mfaAndFederationRequiredForRemoteAccess": ["MFA"]}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_mfaAndFederationRequiredForRemoteAccess_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "teleworkingPolicy": {"mfaAndFederationRequiredForRemoteAccess": ["not an accepted answer"]}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_mfaAndFederationRequiredForRemoteAccess_is_missing if {
	fixture := {"type": ["PolicyDocument"], "teleworkingPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "teleworkingPolicy": {"mfaAndFederationRequiredForRemoteAccess": ["MFA"]}}
	not applicable with input as fixture
}
