package cch.metrics.audit_access_unrestricted_clause_present

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
	compare(data.operator, data.target_value, document.auditClause.unrestrictedAccessGranted)
}
