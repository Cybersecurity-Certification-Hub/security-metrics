package cch.metrics.subcontractor_compliance_monitoring_required

import data.cch.comparison_result
import rego.v1
import input.outsourcingPolicy as outsourcingPolicy

default applicable := false
default compliant := false

applicable if {
	"monitoringObligationStated" in object.keys(outsourcingPolicy)
	is_boolean(outsourcingPolicy.monitoringObligationStated)
	"PolicyDocument" in input.type
}

compliant if {
	every r in results { r.success }
}

message := "The contract identifies subcontracted/external providers and requires them to comply with and be monitored against the security policy." if {
	compliant
} else := "The contract does not require subcontracted/external providers to comply with and be monitored against the security policy." if {
	not compliant
}

results := [comparison_result("outsourcingPolicy.monitoringObligationStated", outsourcingPolicy.monitoringObligationStated)]
