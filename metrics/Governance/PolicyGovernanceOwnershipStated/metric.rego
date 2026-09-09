package cch.metrics.policy_governance_ownership_stated

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.securityPolicy
}

compliant if {
	compare(data.operator, data.target_value, document.securityPolicy.ownerAndApprovalDefined)
}
