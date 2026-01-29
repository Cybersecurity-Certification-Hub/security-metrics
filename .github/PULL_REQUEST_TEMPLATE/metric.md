## New Compliance Metric Pull Request

To propose a new compliance metric, please make sure to **check off each box** below:

- [ ] I have created a folder with the new <MetricName> within an existing category folder (e.g., `metrics/EndpointSecurity`) or create a new category folder.
- [ ] I have created a file `data.json` ([example](https://github.com/Cybersecurity-Certification-Hub/security-metrics/blob/main/metrics/TransportEncryption/TransportEncryptionEnabled/data.json), [template](https://github.com/Cybersecurity-Certification-Hub/security-metrics/blob/main/templates/metric/data.json)).
- [ ] I have created a file `<MetricName>.yaml` ([example](https://github.com/Cybersecurity-Certification-Hub/security-metrics/blob/main/metrics/TransportEncryption/TransportEncryptionEnabled/TransportEncryptionEnabled.yaml), [template](https://github.com/Cybersecurity-Certification-Hub/security-metrics/blob/main/templates/metric/MetricsIdentifier.yaml)).
- [ ] I have created a file `metric.rego` ([example](https://github.com/Cybersecurity-Certification-Hub/security-metrics/blob/main/metrics/TransportEncryption/TransportEncryptionEnabled/metric.rego), [template](https://github.com/Cybersecurity-Certification-Hub/security-metrics/blob/main/templates/metric/metric.rego)).
- [ ] The `<MetricName>.yaml` file is valid according to the [JSON schema](https://github.com/Cybersecurity-Certification-Hub/security-metrics/blob/main/metric_schema.json).
- [ ] The properties used in the `<MetricName>.yaml` and `metric.rego` files are available in the [Ontology](https://github.com/Cybersecurity-Certification-Hub/security-metrics/blob/main/ontology/README.md).
- [ ] I have added a reviewer (e.g., @immqu).
