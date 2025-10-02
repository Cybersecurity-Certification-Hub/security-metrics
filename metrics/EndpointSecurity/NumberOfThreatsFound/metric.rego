package cch.metrics.number_of_threats_found

import data.cch.compare
import input.malwareProtection as mp

default applicable = false

default compliant = false

applicable if {
    mp
}

compliant if {
    detections := mp.numberOfThreatsFound
    compare(data.operator, data.target_value, detections)
}
