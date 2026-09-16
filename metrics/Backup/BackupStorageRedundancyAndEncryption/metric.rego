package cch.metrics.backup_storage_redundancy_and_encryption

import data.cch.comparison_result
import rego.v1
import input.backupPolicy as backupPolicy

default applicable := false
default compliant := false

applicable if {
      backupPolicy != {}
      "PolicyDocument" in input.type
}

compliant if {
      every r in results { r.success }
}

results := [comparison_result("backupPolicy.redundantAndEncrypted", backupPolicy.redundantAndEncrypted)]
