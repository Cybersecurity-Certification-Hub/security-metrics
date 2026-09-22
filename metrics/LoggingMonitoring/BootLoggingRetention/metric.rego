Ja. Die Validierung erfolgt erst bei der Umrechnung; applicable prüft nur die Feldexistenz. Bei einem ungültigen Wert bleibt die Metrik applicable, aber wird nicht compliant.
regopackage cch.metrics.boot_logging_retention

import data.cch.comparison_result
import rego.v1
import input.bootLogging as logging

default applicable := false
default compliant := false

# The metric is applicable when retentionPeriod is present.
applicable if {
	"retentionPeriod" in object.keys(logging)
	"VirtualMachine" in input.type
}

# Converts a valid duration value to days.
retention_period_days := duration_ns / (1000 * 1000 * 1000 * 60 * 60 * 24) if {
	is_string(logging.retentionPeriod)
	duration_ns := time.parse_duration_ns(logging.retentionPeriod)
}

compliant if {
	# Prevents an invalid retention period from being compliant
	# because no comparison result could be created.
	count(results) > 0

	every r in results {
		r.success
	}
}

message := "Boot logging retention is properly configured." if {
	compliant
} else := "Boot logging retention is not properly configured. The retention period in days should match the specified value." if {
	not compliant
}

results := [
	comparison_result(
		"bootLogging.retentionPeriod.days",
		days,
	),
] 