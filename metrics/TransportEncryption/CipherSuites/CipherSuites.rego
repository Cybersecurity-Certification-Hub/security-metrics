package clouditor.metrics.cipher_suites

#import data.compare
import input.transportEncryption as enc

default applicable = false
default compliant = false

applicable if {
	# Check whether the metric is applicable to the assessed resource, i.e. whether it has the `transportEncryption` property set respectively.
	enc
}
compliant if {
	# All cipher suites of the input (enc.cipherSuites) must be included in the set of validated cipher suites (data.target_value.validCipherSuites).
	validCipherSuites := data.target_value.validCipherSuites
	compare(data.operator, validCipherSuites, enc.cipherSuites)
}