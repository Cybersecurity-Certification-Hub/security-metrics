package cch.metrics.clever_robustness_evaluation_enabled

import data.cch.compare

import input.cleverRobustnessEvaluation as cre

default applicable = false
default compliant = false

applicable if {
    cre
}

# min_clever_score >= threshold
compliant if {
    cre.min_clever_score
    compare(data.operator, data.target_value, cre.min_clever_score)
}

