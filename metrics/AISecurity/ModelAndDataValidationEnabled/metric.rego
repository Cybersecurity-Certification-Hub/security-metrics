package cch.metrics.model_and_data_validation_enabled

import data.cch.compare

import input.modelAndDataValidation as mdv

default applicable = false
default compliant = false

applicable if {
    mdv
}

compliant if {
    compare(data.operator, data.target_value, mdv[_].enabled)
}
