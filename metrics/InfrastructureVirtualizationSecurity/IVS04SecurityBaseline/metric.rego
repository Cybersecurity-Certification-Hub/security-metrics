package cch.metrics.ivs04_security_baseline

import data.cch.compare
import rego.v1
import input as vm

default applicable := false

default compliant := false

is_vm if {
	vm.type[_] == "VirtualMachine"
}

expected_names := [
	"ActivityLoggingEnabled",
	"ActivityMonitoringLogDataEnabled",
	"ActivitySecurityAlertsEnabled",
	"BootLoggingEnabled",
	"BootMonitoringLogDataEnabled",
	"BootSecurityAlertsEnabled",
	"OSLoggingEnabled",
	"OSMonitoringLogDataEnabled",
	"OSSecurityAlertsEnabled",
	"ResourceLoggingEnabled",
	"ResourceMonitoringLogDataEnabled",
	"ResourceSecurityAlertsEnabled",
	"AutomaticUpdatesEnabled",
	"MalwareProtectionEnabled",
	"SecureBootEnabled",
	"VTPMEnabled",
	"EncryptionAtHostEnabled",
	"CacheEncryptionEnabled",
	"TempDiskEncryptionEnabled",
	"DataInTransitEncryptedVMStorageEnabled"
]

requirement_value["ActivityLoggingEnabled"] := value if {
	is_vm
	logging := vm.activityLogging
	logging != null
	value := logging.enabled
	value != null
}

requirement_value["ActivityMonitoringLogDataEnabled"] := value if {
	is_vm
	logging := vm.activityLogging
	logging != null
	value := logging.monitoringLogDataEnabled
	value != null
}

requirement_value["ActivitySecurityAlertsEnabled"] := value if {
	is_vm
	logging := vm.activityLogging
	logging != null
	value := logging.securityAlertsEnabled
	value != null
}

requirement_value["BootLoggingEnabled"] := value if {
	is_vm
	logging := vm.bootLogging
	logging != null
	value := logging.enabled
	value != null
}

requirement_value["BootMonitoringLogDataEnabled"] := value if {
	is_vm
	logging := vm.bootLogging
	logging != null
	value := logging.monitoringLogDataEnabled
	value != null
}

requirement_value["BootSecurityAlertsEnabled"] := value if {
	is_vm
	logging := vm.bootLogging
	logging != null
	value := logging.securityAlertsEnabled
	value != null
}

requirement_value["OSLoggingEnabled"] := value if {
	is_vm
	logging := vm.osLogging
	logging != null
	value := logging.enabled
	value != null
}

requirement_value["OSMonitoringLogDataEnabled"] := value if {
	is_vm
	logging := vm.osLogging
	logging != null
	value := logging.monitoringLogDataEnabled
	value != null
}

requirement_value["OSSecurityAlertsEnabled"] := value if {
	is_vm
	logging := vm.osLogging
	logging != null
	value := logging.securityAlertsEnabled
	value != null
}

requirement_value["ResourceLoggingEnabled"] := value if {
	is_vm
	logging := vm.resourceLogging
	logging != null
	value := logging.enabled
	value != null
}

requirement_value["ResourceMonitoringLogDataEnabled"] := value if {
	is_vm
	logging := vm.resourceLogging
	logging != null
	value := logging.monitoringLogDataEnabled
	value != null
}

requirement_value["ResourceSecurityAlertsEnabled"] := value if {
	is_vm
	logging := vm.resourceLogging
	logging != null
	value := logging.securityAlertsEnabled
	value != null
}

requirement_value["AutomaticUpdatesEnabled"] := value if {
	is_vm
	updates := vm.automaticUpdates
	updates != null
	value := updates.enabled
	value != null
}

requirement_value["MalwareProtectionEnabled"] := value if {
	is_vm
	mp := vm.malwareProtection
	mp != null
	value := mp.enabled
	value != null
}

requirement_value["SecureBootEnabled"] := value if {
	is_vm
	security_profile := vm.securityProfile
	security_profile != null
	uefi_settings := security_profile.uefiSettings
	uefi_settings != null
	value := uefi_settings.secureBootEnabled
	value != null
}

requirement_value["VTPMEnabled"] := value if {
	is_vm
	security_profile := vm.securityProfile
	security_profile != null
	uefi_settings := security_profile.uefiSettings
	uefi_settings != null
	value := uefi_settings.vTpmEnabled
	value != null
}

requirement_value["EncryptionAtHostEnabled"] := value if {
	is_vm
	security_profile := vm.securityProfile
	security_profile != null
	encryption_at_host := security_profile.encryptionAtHost
	encryption_at_host != null
	value := encryption_at_host.enabled
	value != null
}

requirement_value["CacheEncryptionEnabled"] := value if {
	is_vm
	security_profile := vm.securityProfile
	security_profile != null
	encryption_at_host := security_profile.encryptionAtHost
	encryption_at_host != null
	value := encryption_at_host.cacheEncryptionEnabled
	value != null
}

requirement_value["TempDiskEncryptionEnabled"] := value if {
	is_vm
	security_profile := vm.securityProfile
	security_profile != null
	encryption_at_host := security_profile.encryptionAtHost
	encryption_at_host != null
	value := encryption_at_host.tempDiskEncryptionEnabled
	value != null
}

requirement_value["DataInTransitEncryptedVMStorageEnabled"] := value if {
	is_vm
	security_profile := vm.securityProfile
	security_profile != null
	encryption_at_host := security_profile.encryptionAtHost
	encryption_at_host != null
	value := encryption_at_host.dataInTransitEncryptedVmStorageEnabled
	value != null
}

actual_names := { name |
	some idx
	expected_names[idx] = name
	_ := requirement_value[name]
}

missing_names := { name |
	some idx
	expected_names[idx] = name
	not requirement_defined(name)
}

requirement_defined(name) if {
	_ := requirement_value[name]
}

non_compliant if {
	some idx
	expected_names[idx] = name
	value := requirement_value[name]
	not compare(data.operator, data.target_value, value)
}

applicable if {
	is_vm
	count(actual_names) > 0
}

compliant if {
	is_vm
	count(actual_names) > 0
	count(missing_names) == 0
	not non_compliant
	compare(data.operator, data.target_value, true)
}
