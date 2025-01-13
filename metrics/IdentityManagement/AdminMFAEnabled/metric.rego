package metrics.iam.admin_mfa_enabled

import data.compare
import rego.v1
import input as identity

default applicable = false

default compliant = false

applicable {
	# we are only interested in some kind of privileged user    
	identity.privileged
}

compliant {
	compare(data.operator, data.target_value, identity.enforceMFA)
}
