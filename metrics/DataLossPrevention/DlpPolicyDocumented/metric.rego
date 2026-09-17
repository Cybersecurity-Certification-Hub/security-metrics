package cch.metrics.dlp_policy_documented

import data.cch.comparison_result
import rego.v1
import input.dataConfidentialitySDNPolicy as dataConfidentialitySDNPolicy

default applicable := false
default compliant := false

applicable if {
	"restrictsDownloadAndExtraction" in object.keys(dataConfidentialitySDNPolicy)
	is_boolean(dataConfidentialitySDNPolicy.restrictsDownloadAndExtraction)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The Data Loss Prevention policy restricts downloading and extracting information." if {
	compliant
} else := "The Data Loss Prevention policy does not restrict downloading and extracting information." if {
	not compliant
}

results := [comparison_result("dataConfidentialitySDNPolicy.restrictsDownloadAndExtraction", dataConfidentialitySDNPolicy.restrictsDownloadAndExtraction)]
