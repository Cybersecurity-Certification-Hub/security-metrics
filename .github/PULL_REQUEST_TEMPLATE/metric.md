## New Compliance Metric Pull Request
To create a new metric, please **check off every box** and adapt the examples below:

- [ ] I have created/updated `data.json`.
- [ ] I have created `<MetricName>.yaml` (e.g., `AutomaticUpdatesInterval.yaml`).
- [ ] I have created `metric.rego`.
- [ ] All linters/tests pass.
- [ ] Reviewers have been added (@immqu).

### Required Files and Example Skeletons

<details>
<summary>data.json</summary>

```
{ 
    "operator": "==", 
    "target_value": true 
}
```

</details>

<details>
<summary> Example TransportEncryptionEnabled.yaml</summary>
	
The yaml file is described by metadata and configuration properties. The json schema for this file can be found [here](metric_schema.json).
A description of the properties can be found [here](README.md)

```

# ====== Metadata ======
id: TransportEncryptionEnabled
description: This rule assesses whether a [Resource] has [TransportEncryption] [p1:enabled] correctly configured.
category: TransportEncryption
version: "1.0" 
comments: Transport encryption is a standard practice to keep sensitive data confidential when it is transmitted.
# ====== Configuration ======
configuration:
  p1:
    operator: "=="
    targetValue: True

```

</details>

<details>
<summary>metric.rego</summary>

The package name must be updated to match the metric name. An example of a `Object Storage Service` resource evaluated by this metric is shown under the metric.

```
package cch.metrics.transport_encryption_enabled

import data.cch.compare
import rego.v1
import input.transportEncryption as enc

default compliant = false

default applicable = false

applicable if {
	enc
}

compliant if {
	compare(data.operator, data.target_value, enc.enabled)
}

```


<details>
<summary>Resource example</summary>

```
"objectStorageService": {
    "parentId": "ResourceGroup1",
    "name": "Storage 1",
    "httpEndpoint": {
    "url": "https://example.de/stoarage1",
    "transportEncryption": {
        "protocolVersion": 1.2,
        "enabled": true,
        "enforced": true,
        "protocol": "TLS"
    }
    },
    "transportEncryption": {
    "protocolVersion": 1.2,
    "enabled": true,
    "enforced": true,
    "protocol": "TLS"
    },
    "storageIds": [
    "fileStorage1"
    ],
    "creationTime": "2020-10-28T09:52:33.226201900Z",
    "raw": "some raw information",
    "labels": {
    "env": "prod"
    },
    "id": "storage1",
    "geoLocation": {
    "region": "westeurope"
    }
}
```
</details>
</details>
