package cch.metrics.audit_log_review_process_documented

import data.cch.all_compliant
import data.cch.comparison_result
import input.auditLogMonitoringPolicy as auditLogMonitoringPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"monitoringMechanisms" in object.keys(auditLogMonitoringPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The log management procedure requires periodic monitoring and anomaly review of audit logs." if {
	compliant
} else := "The log management procedure does not require periodic monitoring and anomaly review of audit logs." if {
	not compliant
}

results := [comparison_result("auditLogMonitoringPolicy.monitoringMechanisms", auditLogMonitoringPolicy.monitoringMechanisms)]
