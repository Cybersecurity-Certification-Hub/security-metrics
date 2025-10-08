package cch.metrics.block_cipher_mode

import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
  document.TransportEncryption
  document.TransportEncryption.cipherSuites
  count(document.TransportEncryption.cipherSuites) > 0
}

compliant if {
  applicable
  every cs in document.TransportEncryption.cipherSuites {
    cs.sessionCipher
    regex.match(data.target_value, cs.sessionCipher)
  }
}
