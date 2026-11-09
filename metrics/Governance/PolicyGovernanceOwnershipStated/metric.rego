package cch.metrics.policy_governance_ownership_stated

import data.cch.all_compliant
import data.cch.comparison_result
import input.securityPolicyReview as securityPolicyReview
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"ownerAndApprovalDefined" in object.keys(securityPolicyReview)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The policy identifies an accountable owner and carries an approval date/signature." if {
	compliant
} else := "The policy does not identify an accountable owner and an approval date/signature." if {
	not compliant
}

results := [comparison_result("securityPolicyReview.ownerAndApprovalDefined", securityPolicyReview.ownerAndApprovalDefined)]
