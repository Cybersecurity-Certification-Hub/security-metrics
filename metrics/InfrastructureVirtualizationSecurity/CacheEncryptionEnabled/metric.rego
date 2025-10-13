package cch.metrics.cache_encryption_enabled

import data.cch.compare
import rego.v1
import input as vm

default applicable := false

default compliant := false

applicable if {
	vm.type[_] == "VirtualMachine"
	security_profile := vm.securityProfile
	security_profile != null
	encryption_at_host := security_profile.encryptionAtHost
	encryption_at_host != null
	encryption_at_host.cacheEncryptionEnabled != null
}

compliant if {
	vm.type[_] == "VirtualMachine"
	security_profile := vm.securityProfile
	security_profile != null
	encryption_at_host := security_profile.encryptionAtHost
	encryption_at_host != null
	value := encryption_at_host.cacheEncryptionEnabled
	compare(data.operator, data.target_value, value)
}
