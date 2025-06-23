package cch.metrics.machine_learning_model_privacy

import data.cch.compare
import rego.v1

default applicable = false
default compliant = false

applicable if {
	input.type[_] == "MachineLearningModel"
	input.privacy.privacyTechniqueUsed
	input.privacy.privacyGuaranteeLevel
}

compliant if {
	input.privacy.privacyTechniqueUsed == "SHAPr"
	compare("<=", 0.5, input.privacy.privacyGuaranteeLevel)
} 
