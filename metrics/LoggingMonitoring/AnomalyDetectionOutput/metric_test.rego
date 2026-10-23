package cch.metrics.anomaly_detection_output

import rego.v1

test_compliant_when_logging_service_ids_are_set if {
	fixture := {"type": ["DatabaseService"], "anomalyDetection": {"applicationLogging": {"loggingServiceIds": ["log-1"]}}}
	applicable with input as fixture
	compliant with input as fixture
}

# protojson omits empty repeated fields, so missing logging service IDs count as zero
test_not_compliant_has_details_when_logging_service_ids_are_missing if {
	fixture := {"type": ["DatabaseService"]}
	applicable with input as fixture
	not compliant with input as fixture
	rs := results with input as fixture
	count(rs) == 1
	rs[0].value == 0
	rs[0].success == false
}

test_not_applicable_when_not_a_database_service if {
	fixture := {"type": ["VirtualMachine"]}
	not applicable with input as fixture
}
