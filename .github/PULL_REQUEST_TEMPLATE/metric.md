## New Compliance Metric Pull Request

To propose a new compliance metric, please make sure to **check off each box** below:

- [ ] I have created a folder with the <MetricName>.
- [ ] I have created a file `data.json` ([example](metrics/TransportEncryption/TransportEncryptionEnabled/data.json)).
- [ ] I have created a file `<MetricName>.yaml` ([example](metrics/TransportEncryption/TransportEncryptionEnabled/TransportEncryptionEnabled.yml)).
- [ ] I have created a file `metric.rego` ([example](metrics/TransportEncryption/TransportEncryptionEnabled/metric.rego)).
- [ ] The <metric.rego> file is valid according to the [JSON schema](metric_schema.json).
- [ ] The properties used in the `<MetricName>.yaml` and `metric.rego` files are available in the [Ontology](ontology/README.md).
- [ ] I have added a reviewer (e.g., @immqu).
