package cch.metrics.audit_access_unrestricted_clause_present

import data.cch.comparison_result
import rego.v1
import input.auditClause as auditClause

default applicable := false
default compliant := false

applicable if {
      auditClause != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("auditClause.unrestrictedAccessGranted", auditClause.unrestrictedAccessGranted)]
