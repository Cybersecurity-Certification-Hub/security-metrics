package cch.metrics.machine_learning_model_poison

import data.cch.compare
import rego.v1

default applicable = false
default compliant = false


applicable if {
    input.type[_] == "MachineLearningModel"
    input.poison.poisonDefenseEnabled == true
    input.poison.metricType == "SLEEPAgent"
    input.poison.poisonLevel
}


compliant if {
    compare("<=", 0.5, input.poison.poisonLevel)
}
