package cch.metrics.object_storage_public_access_disabled

import data.cch.comparison_result
import rego.v1

import input as storage

default compliant = false

default applicable = false

applicable if {
	# the resource type should be an ObjectStorage
	input.type[_] == "ObjectStorage"
	"publicAccess" in object.keys(input)
}

compliant if {
	every r in results { r.success }
}

results := [comparison_result("publicAccess", storage.publicAccess)]
