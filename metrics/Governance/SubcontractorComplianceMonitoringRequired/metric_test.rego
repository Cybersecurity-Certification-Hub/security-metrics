package cch.metrics.subcontractor_compliance_monitoring_required

import rego.v1

test_compliant_when_monitoringObligationStated_is_valid if {
	fixture := {"type": ["PolicyDocument"], "outsourcingPolicy": {"monitoringObligationStated": true}}
	applicable with input as fixture
	compliant with input as fixture
}

test_not_compliant_when_monitoringObligationStated_is_out_of_range if {
	fixture := {"type": ["PolicyDocument"], "outsourcingPolicy": {"monitoringObligationStated": false}}
	applicable with input as fixture
	not compliant with input as fixture
}

test_not_applicable_when_monitoringObligationStated_is_missing if {
	fixture := {"type": ["PolicyDocument"], "outsourcingPolicy": {}}
	not applicable with input as fixture
}

test_not_applicable_when_type_is_not_policy_document if {
	fixture := {"type": ["Resource"], "outsourcingPolicy": {"monitoringObligationStated": true}}
	not applicable with input as fixture
}
