package cch.metrics.subcontractor_monitoring_cadence_defined

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

results := [comparison_result("outsourcing.monitoringMechanism", outsourcing.monitoringMechanism)]
