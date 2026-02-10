package cch.metrics.secure_boot_enabled

import data.cch.compare
import rego.v1
import input as vm

default applicable := false

default compliant := false

applicable if {
	vm.type[_] == "VirtualMachine"
	security_profile := vm.securityProfile
	security_profile != null
	uefi_settings := security_profile.uefiSettings
	uefi_settings != null
	uefi_settings.secureBootEnabled != null
}

compliant if {
	vm.type[_] == "VirtualMachine"
	security_profile := vm.securityProfile
	security_profile != null
	uefi_settings := security_profile.uefiSettings
	uefi_settings != null
	value := uefi_settings.secureBootEnabled
	compare(data.operator, data.target_value, value)
}
