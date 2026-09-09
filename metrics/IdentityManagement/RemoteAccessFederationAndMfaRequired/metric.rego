package cch.metrics.remote_access_federation_and_mfa_required

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
	document != {}
	"PolicyDocument" in document.type
	document.iam
}

compliant if {
	compare(data.operator, data.target_value, document.iam.mfaAndFederationRequiredForRemoteAccess)
}
