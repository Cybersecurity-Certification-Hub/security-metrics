package metrics.logging_monitoring.boot_logging_output

import data.compare
import rego.v1
import input.bootLogging as logging

default applicable = false

default compliant = false

applicable {
	logging
}

compliant {
	compare(data.operator, data.target_value, count(logging.loggingServiceIds))
}
