package cch.metrics.policy_governance_ownership_stated

import data.cch.comparison_result
import rego.v1
import input.securityPolicyReview as securityPolicyReview

default applicable := false
default compliant := false

applicable if {
	"ownerAndApprovalDefined" in object.keys(securityPolicyReview)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The policy identifies an accountable owner and carries an approval date/signature." if {
	compliant
} else := "The policy does not identify an accountable owner and an approval date/signature." if {
	not compliant
}

results := [comparison_result("securityPolicyReview.ownerAndApprovalDefined", securityPolicyReview.ownerAndApprovalDefined)]
