package cch.metrics.policy_governance_ownership_stated

import data.cch.comparison_result
import rego.v1
import input.securityPolicy as securityPolicy

default applicable := false
default compliant := false

applicable if {
      securityPolicy != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("securityPolicy.ownerAndApprovalDefined", securityPolicy.ownerAndApprovalDefined)]
