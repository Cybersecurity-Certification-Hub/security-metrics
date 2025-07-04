package metrics.csaf.document_csaf_red_restricted

import data.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

restricted := ["RED", "AMBER"]

applicable if {
	# check resource type
	"SecurityAdvisoryDocument" in document.type

	# check, if document is restricted (i.e. RED/AMBER) labeled
	document.labels.tlp in restricted
}

compliant if {
	# RED/AMBER must NOT be freely accessible
	auth := document.dataLocation.remoteDataLocation.authenticity
	not auth.noAuthentication
}
