package cch.metrics.web_application_firewall_enabled

import data.cch.all_compliant
import data.cch.comparison_result
import input.accessRestriction.webApplicationFirewall as webApp
import rego.v1

default applicable := false

default compliant := false

applicable if {
	"enabled" in object.keys(webApp)

	# the resource type should be an Load Balancer
	input.type[_] == "LoadBalancer"
}

compliant if {
	all_compliant(results)
}

results := [comparison_result("accessRestriction.webApplicationFirewall.enabled", webApp.enabled)]
