package cch.metrics.subcontractor_monitoring_cadence_defined

import rego.v1

test_compliant_when_monitoringMechanism_is_valid if {
	fixture := {"type": ["PolicyDocument"], "outsourcingPolicy": {"monitoringMechanism": "annual review"}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_monitoringMechanism_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "outsourcingPolicy": {"monitoringMechanism": "not an accepted answer"}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_monitoringMechanism_is_missing if {
	fixture := {"type": ["PolicyDocument"], "outsourcingPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "outsourcingPolicy": {"monitoringMechanism": "annual review"}}
	not applicable with input as fixture
}
