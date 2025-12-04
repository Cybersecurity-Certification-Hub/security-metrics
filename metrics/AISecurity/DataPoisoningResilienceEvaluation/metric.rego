#assume input {
#  "dataPoisoningEvaluation": {
#    "attack_success_rate": 0.07
#  }
#}

package cch.metrics.data_poisoning_resilience_enabled

import data.cch.compare

import input.dataPoisoningEvaluation as dpe

default applicable = false
default compliant = false

# if we have data poisoning evaluation 
applicable if {
    dpe
}

# attack_success_rate must <= defined threshold
compliant if {
    dpe.attack_success_rate
    compare(data.operator, data.target_value, dpe.attack_success_rate)
}

