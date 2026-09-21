package cch.metrics.audit_log_review_process_documented

import data.cch.comparison_result
import rego.v1
import input.auditLogMonitoringPolicy as auditLogMonitoringPolicy

default applicable := false
default compliant := false

applicable if {
	"enabled" in object.keys(auditLogMonitoringPolicy)
	is_boolean(anomalyDetection.enabled)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The log management procedure requires periodic monitoring and anomaly review of audit logs." if {
	compliant
} else := "The log management procedure does not require periodic monitoring and anomaly review of audit logs." if {
	not compliant
}

results := [comparison_result("auditLogMonitoringPolicy.enabled", auditLogMonitoringPolicy.enabled)]
