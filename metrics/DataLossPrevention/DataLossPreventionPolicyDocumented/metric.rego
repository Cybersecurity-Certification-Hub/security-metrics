package cch.metrics.data_loss_prevention_policy_documented

import data.cch.all_compliant
import data.cch.comparison_result
import input.dataConfidentialitySdnPolicy as dataConfidentialitySDNPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"restrictsDownloadAndExtraction" in object.keys(dataConfidentialitySDNPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The Data Loss Prevention policy restricts downloading and extracting information." if {
	compliant
} else := "The Data Loss Prevention policy does not restrict downloading and extracting information." if {
	not compliant
}

results := [comparison_result("dataConfidentialitySdnPolicy.restrictsDownloadAndExtraction", dataConfidentialitySDNPolicy.restrictsDownloadAndExtraction)]
