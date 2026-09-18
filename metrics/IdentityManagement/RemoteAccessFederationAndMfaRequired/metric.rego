package cch.metrics.remote_access_federation_and_mfa_required

import data.cch.comparison_result
import rego.v1
import input.iam as iam

default applicable := false
default compliant := false

applicable if {
      iam != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("iam.mfaAndFederationRequiredForRemoteAccess", iam.mfaAndFederationRequiredForRemoteAccess)]
