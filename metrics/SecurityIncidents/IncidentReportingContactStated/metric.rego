package cch.metrics.incident_reporting_contact_stated

import data.cch.comparison_result
import rego.v1
import input.securityIncident as securityIncident

default applicable := false
default compliant := false

applicable if {
      securityIncident != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("securityIncident.reportingContactStated", securityIncident.reportingContactStated)]
