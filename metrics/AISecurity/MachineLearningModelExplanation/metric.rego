package cch.metrics.machine_learning_model_explanation

import data.cch.compare
import rego.v1

default applicable = false
default compliant = false

applicable if {
    input.type[_] == "MachineLearningModel"
    input.explanation.explanationEnabled == true
    input.explanation.explanationMethod == "Geek"
} else if {
    input.explanation.explanationMethod == "LIME"
} 

compliant if {
    compare("==", 1, input.explanation.explanationQuality)
}
