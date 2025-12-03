package cch.metrics.password_login_attempts_q1

import data.cch.compare
import rego.v1
import input as document

default applicable := false

default compliant := false

applicable if {
}

compliant if {
    compare(data.operator, data.target_value, document:AccessManagement.Password.allowedLoginAttepts)
}
