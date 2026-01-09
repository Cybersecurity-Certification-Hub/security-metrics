package cch.metrics.lime_explanation_enabled

import data.cch.compare

import input.limeExplanation as lime

default applicable = false
default compliant = false


applicable if {
    lime
}

# lime.enabled == true
compliant if {
    compare(data.operator, data.target_value, lime.enabled)
}
