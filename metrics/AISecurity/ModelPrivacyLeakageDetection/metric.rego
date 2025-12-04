# assumed our input is 
#{
#  "modelLeakageDetection": {
#    "max_final_shapr_score": 0.37
#  }
#}

package cch.metrics.model_leakage_detection_enabled

import data.cch.compare

import input.modelLeakageDetection as mld

default applicable = false
default compliant = false


applicable if {
    mld
}

# max_final_shapr_score must <= data.target_value（such as 0.5）
compliant if {
    mld.max_final_shapr_score
    compare(data.operator, data.target_value, mld.max_final_shapr_score)
}
