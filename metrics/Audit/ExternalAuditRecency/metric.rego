package cch.metrics.external_audit_recency

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.auditClause
}

compliant if {
	compare(data.operator, data.target_value, document.auditClause.daysSinceLastAudit)
}
