package cch.metrics.password_hash_algorithm_allowed

import data.cch.compare
import rego.v1
import input as app

default applicable = false

default compliant = false

hashes := [func | func := app.functionalities[_]; func.cryptographicHash]

applicable if {
	app.type[_] == "Application"
}

compliant if {
	count(violations) == 0
}

message := "The analyzed resource uses approved password hashing algorithms." if {
	compliant
} else := "The analyzed resource contains evidence of weak password hashing algorithms." if {
	not compliant
}

results := [
	mapped |
	func := app.functionalities[_]
	mapped := {
		"property": "cryptographicHash.algorithm",
		"value": func.cryptographicHash.algorithm,
		"target_value": data.target_value,
		"operator": data.operator,
		"success": compare(data.operator, data.target_value, func.cryptographicHash.algorithm),
	}
]

violations := [x | y := results[_]; y.success == false; x = y]
