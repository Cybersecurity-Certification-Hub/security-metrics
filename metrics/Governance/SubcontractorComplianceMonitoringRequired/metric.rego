package cch.metrics.subcontractor_compliance_monitoring_required

import data.cch.all_compliant
import data.cch.comparison_result
import input.outsourcingPolicy as outsourcingPolicy
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"monitoringObligationStated" in object.keys(outsourcingPolicy)
	"PolicyDocument" in input.type
}

compliant if {
	all_compliant(results)
}

message := "The contract identifies subcontracted/external providers and requires them to comply with and be monitored against the security policy." if {
	compliant
} else := "The contract does not require subcontracted/external providers to comply with and be monitored against the security policy." if {
	not compliant
}

results := [comparison_result("outsourcingPolicy.monitoringObligationStated", outsourcingPolicy.monitoringObligationStated)]
