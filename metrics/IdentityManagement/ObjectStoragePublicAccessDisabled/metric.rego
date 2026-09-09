package cch.metrics.object_storage_public_access_disabled

import data.cch.compare
import data.cch.comparison_result
import rego.v1

import input as storage

default compliant = false

default applicable = false

applicable if {
	# the resource type should be an ObjectStorage
	storage.type[_] == "ObjectStorage"
}

compliant if {
	compare(data.operator, data.target_value, storage.publicAccess)
}

results := [comparison_result("publicAccess", storage.publicAccess)]
