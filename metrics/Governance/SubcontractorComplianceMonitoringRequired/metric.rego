package cch.metrics.subcontractor_compliance_monitoring_required

import data.cch.comparison_result
import rego.v1
import input.outsourcing as outsourcing

default applicable := false
default compliant := false

applicable if {
      outsourcing != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("outsourcing.monitoringObligationStated", outsourcing.monitoringObligationStated)]
