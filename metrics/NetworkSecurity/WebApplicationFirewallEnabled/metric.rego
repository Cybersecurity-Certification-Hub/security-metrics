package cch.metrics.web_application_firewall_enabled

import data.cch.compare
import data.cch.comparison_result
import rego.v1
import input.accessRestriction.webApplicationFirewall as webApp

default applicable = false

default compliant = false

applicable if {
	webApp
    # the resource type should be an Load Balancer
	input.type[_] == "LoadBalancer"
}

compliant if {
	compare(data.operator, data.target_value, webApp.enabled)
}

results := [comparison_result("accessRestriction.webApplicationFirewall.enabled", webApp.enabled)]
