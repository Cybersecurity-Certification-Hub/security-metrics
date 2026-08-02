# Contributing Metrics to Security Metrics

This document provides comprehensive guidance for creating new security metrics for the security-metrics project. It is designed to be precise and detailed for both human contributors and AI tools.

## Overview

A security metric is a reusable assessment unit that evaluates compliance against security policies and standards. Each metric consists of:

1. **Metadata and configuration** (YAML file)
2. **Evaluation logic** (Rego policy file)
3. **Comparison operators** (data.json file)
4. **Ontology entries** (OWL/XML files)

The metric framework evaluates policy documents and security assessments against defined criteria, producing compliance verdicts.

## Project Structure

```
security-metrics/
├── metrics/
│   ├── <Category1>/
│   │   ├── <MetricName1>/
│   │   │   ├── <MetricName1>.yaml
│   │   │   ├── metric.rego
│   │   │   └── data.json
│   │   └── <MetricName2>/
│   │       ├── <MetricName2>.yaml
│   │       ├── metric.rego
│   │       └── data.json
│   └── <Category2>/
│       └── ...
└── ontology/
    ├── v1/
    │   ├── core.owx
    │   ├── data.owx
    │   ├── resource.owx
    │   ├── resource/
    │   └── core/
    └── ontology.owx
```

### Existing Categories

The project currently includes the following metric categories (all use UpperCamelCase):

- **AISecurity** - AI/ML security and governance
- **ApplicationSecurity** - Application-level security controls
- **AssetManagement** - Asset inventory and lifecycle management
- **Backup** - Backup and recovery procedures
- **CSAF** - Common Security Advisory Framework related metrics
- **DevelopmentLifeCycle** - Secure development practices
- **EndpointSecurity** - Endpoint protection and hardening
- **Governance** - Security governance and policy
- **IdentityManagement** - Identity and access management (IAM)
- **LoggingMonitoring** - Logging, monitoring, and auditing
- **NetworkSecurity** - Network security controls
- **PlatformSecurity** - Platform/infrastructure security
- **QuantumSecurity** - Quantum-resistant cryptography
- **SecurityIncidents** - Incident response and reporting
- **StorageEncryption** - Data storage encryption controls
- **TransportEncryption** - Data in-transit encryption

You may select one of these existing categories or create a new one if your metric does not fit into any existing category. When creating a new category, align it with established security standards and frameworks (e.g., NIST, CIS, ISO 27001) or use domain logic that clearly separates a new area of concern from existing categories.

## Creating a New Metric

### Step 1: Choose or Create a Category

A category is a directory under `metrics/` that groups related metrics. Category names must follow **UpperCamelCase** convention, with acronyms in capital letters (e.g., `AISecurity`, `CSAF`, `IAM`).

**Selecting an existing category:**
- Review the list above and choose the most semantically appropriate category
- Example: A metric about SSH key management belongs in `IdentityManagement`

**Creating a new category:**
- Create a new directory under `metrics/` with a descriptive UpperCamelCase name
- Only create a new category if no existing category adequately describes your metric's domain
- Example: For quantum cryptography metrics, a new `QuantumSecurity` category was created

### Step 2: Create the Metric Folder

Within your chosen category directory, create a new folder named after your metric. The metric folder name must be:

- **UpperCamelCase** (e.g., `IncidentReportingTeam`, `BootLoggingRetention`)
- **Descriptive** - clearly indicate what the metric assesses
- **Unique** within the category

### Step 3: Create the Three Required Files

Each metric folder must contain exactly three files:

#### 3a. `<MetricName>.yaml` - Metadata and Configuration File

This file defines the metric's metadata, implementation guidelines, and evaluation configuration.

**Structure and Content:**

```yaml
# ====== Metadata ======
id: "<UUID>"  # Unique identifier for the metric (generate a new UUID v4)
name: "<MetricName>"  # Must match the metric folder name
description: "This rule assesses whether a [OntologyClass] with [propertyName] has [p1:parameterName] configured correctly."

# Implementation guidelines for evidence collectors (optional)
# Each evidence collector defines its own fields for guiding evidence collection
implementationGuidelines:
  <EvidenceCollector1>:  # e.g., AMOE
    # Fields are specific to each collector and may vary
    # (question, keywords, details, previous_name, etc.)
  <EvidenceCollector2>:  # e.g., FSC
    # Different collectors may define different fields

category: "<Category>"  # Must match the parent directory name (e.g., NetworkSecurity, IdentityManagement)
version: "v1"  # Ontology version (currently always v1)
comments: "Human-readable explanation of the metric's purpose, business context, or rationale."

# ====== Configuration ======
configuration:
  p1:
    operator: "=="  # Choose from: ==, isIn, <=, >=, <, >, allIn
    targetValue: [...]  # Expected value(s) for compliance
  p2:  # Optional, for additional parameters
    operator: "=="
    targetValue: [...]
```

**Key Guidelines:**

- **id**: Generate a unique UUID v4 using `uuidgen` or online UUID generator
- **name**: Exactly match the metric folder name and the YAML filename (without .yaml extension)
- **description**: A glossary-style text that is human-readable natural language with technical terms in square brackets. Technical terms (in brackets) must match ontology concepts. This combines readability with semantic precision. Format: "This rule assesses whether a [OntologyClass] with property [propertyName] meets [configuration criteria]." For AMOE metrics evaluating policies, reference the policy type and its properties (e.g., "[DataConfidentialitySDNPolicy]" with "[p1:isDefined]"). See "Policy Handling (AMOE Metrics)" under General Patterns and Conventions.
- **implementationGuidelines** (optional): Maps evidence collectors (e.g., AMOE, FSC) to their specific collection parameters. The structure and fields within each collector's section are defined by that collector and may vary. This guides external tools on how to gather evidence for this metric. For AMOE metrics, include questions and keywords that help identify policy sections in documents.
- **category**: Must exactly match the parent directory name
- **version**: Currently always "v1" unless you're targeting a future ontology version
- **configuration**: Define parameters (p1, p2, etc.) that drive the Rego evaluation logic
  - Each parameter should use an appropriate operator from `metrics/operators.rego` (e.g., `==`, `isIn`, `<=`)
  - `targetValue` is the static expected value or list of acceptable values for compliance (e.g., `["Security Committee"]`, `false`, `true`)
  - The Rego policy extracts actual values from the input document and compares them against these targetValues

**Examples:**

Example with AMOE (policy document evidence collector):
```yaml
id: "5df7827e-00b2-4086-af1a-ed4c3b8ce397"
name: "IncidentReportingTeam"
description: "This rule assesses whether a [PolicyDocument] includes [SecurityIncident] with [p1:team] set correctly."

implementationGuidelines:
  AMOE:
    question: "To whom must cybersecurity incidents affecting the company's services be reported?"
    is_headline_based: false
    keywords: ["security incident", "team"]

category: "SecurityIncidents"
version: "v1"
comments: "This metric assesses if incident reporting team is defined."

configuration:
  p1:
    operator: "isIn"
    targetValue: ["Security Committee"]
```

Example with FSC (a different evidence collector with different fields):
```yaml
id: "d8f28ac7-eee9-41b6-b898-cc7d7d91c6f0"
name: "ChangeApprovalBeforeDeployment"
description: "This rule assesses whether a [Resource] includes [RequestForChange] with [p1:approvedBeforeDeployment] set correctly."

implementationGuidelines:
  FSC:
    details: ["- Date and time of change approval and deployment", "- Information from Change ticket"]
    previous_name: "MT-CCM-04.1H-1"

category: "DevelopmentLifeCycle"
version: "v1"
comments: "Check whether there was a change approval before deployment to production."

configuration:
  p1:
    operator: "=="
    targetValue: true
```

Example without implementationGuidelines (optional section omitted):
```yaml
id: "eeda50fb-7064-4607-a5bf-7c9d3b54a8d6"
name: "VirtualMachinePublicIpDisabled"
description: "This rule assesses whether a [VirtualMachine] that offers the property [internetAccessibleEndpoint], has [p1:internetAccessibleEndpoint] configured correctly."

category: "NetworkSecurity"
version: "v1"
comments: "Compute instances (virtual machines) should not have public IP addresses assigned, as direct internet exposure increases the attack surface significantly."

configuration:
  p1:
    operator: "=="
    targetValue: false
```

#### 3b. `data.json` - Parameter Comparison Data

This file stores the data that the Rego policy uses for evaluation. It mirrors the configuration from the YAML file in JSON format.

**Structure:**

```json
{
    "operator": "==|>=|<=|<|>|isIn|allIn",
    "target_value": [...]
}
```

Or for multiple parameters:

```json
{
    "p1": {
        "operator": "operatorName",
        "target_value": [...]
    },
    "p2": {
        "operator": "operatorName",
        "target_value": [...]
    }
}
```

**Key Guidelines:**

- Use `snake_case` for JSON keys (e.g., `target_value`, not `targetValue`)
- The `operator` must be defined in `metrics/operators.rego`
- The `target_value` should match the configuration in the YAML file
- Keep the JSON structure flat and simple - complex logic belongs in the Rego policy

**Example with multiple values:**

```json
{
    "operator": "isIn",
    "target_value": ["Security Committee", "CISO Office", "Security Team"]
}
```

**Example with single value:**

```json
{
    "operator": "==",
    "target_value": false
}
```

#### 3c. `metric.rego` - Evaluation Logic File

This file contains the Rego policy that evaluates compliance. Rego is a declarative policy language designed for policies and access control.

**Structure:**

```rego
package cch.metrics.<metric_name_snake_case>

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
    # Define conditions when this metric is applicable to the document
    # Example: document.securityIncident != {}
    # Example: "PolicyDocument" in document.type
}

compliant if {
    # Define conditions for compliance
    # Use the compare/3 function to evaluate configuration parameters
    # Example: compare(data.operator, data.target_value, document.team)
}

message := "Compliance message when compliant." if {
    compliant
} else := "Non-compliance message when not compliant." if {
    not compliant
}
```

**Key Guidelines:**

- **Package name**: Use `cch.metrics.<metric_name_snake_case>` format
  - Convert UpperCamelCase metric name to snake_case
  - Consecutive uppercase letters (acronyms) stay together and are lowercased
  - Examples:
    - `IncidentReportingTeam` → `cch.metrics.incident_reporting_team`
    - `TlsCipherSuite` → `cch.metrics.tls_cipher_suite`
    - `AdminMFAEnabled` → `cch.metrics.admin_mfa_enabled`
    - `RestrictSSH` → `cch.metrics.restrict_ssh`
- **Imports**: Always include:
  - `import data.cch.compare` - Function for comparing values with operators
  - `import rego.v1` - Rego v1 syntax
  - `import input as document` - General reference to entire input document (common when assessing policy documents), or use `import input.<fieldName> as <alias>` to import specific nested input fields directly. This pattern works for any input field type: policies (e.g., `accessControlTypePolicy`), features/functionalities (e.g., `bootLogging`), or nested structures (e.g., `accessRestriction.l3Firewall`). Using aliases makes the Rego logic more readable when focusing on a specific input structure.
- **Default values**: Set default values for `applicable` and `compliant` to `false`
- **applicable rule**: Define when this metric should be evaluated
  - Check for input type like `input.type[_] == "NetworkInterface"`
  - In most cases we additionally check for presence of relevant fields with `<variable> != {}`. This ensures we only assess evidence that provides the required field. Add a comment explaining why: e.g., `networkThreatMitigationPolicy != {} # only evaluate if policy is provided`. It could also be correct to omit this check, which means we require the evidence to include this field (i.e., the metrics will be checked against the evidence regardless of whether it contains the relevant field). When reviewing already existing metrics: If this check is not done, raise at least a warning.
  - For AMOE metrics evaluating policies: We want to check that input is a policy document (`"PolicyDocument" in input.type`) and that the policy is present (e.g., `leastPrivilegePolicy != {}`). The latter we do for now because AMOE can only provide evidence for one policy at a time. In the future, though, we want one evidence for all policies in the document and, thus, omit this second check.
  - Return false by default (fail-safe)
- **compliant rule**: Define when the document passes this metric
  - Use `compare(data.operator, data.target_value, document_field)` to evaluate
  - The `compare` function handles all operator logic (==, isIn, <=, >=, etc.)
  - Can combine multiple conditions with `and` logic
  - For AMOE metrics evaluating policies: extract specific policy properties (e.g., `document.dataConfidentialitySDNPolicy.isDefined`) and compare against targetValue. See "Policy Handling (AMOE Metrics)" under General Patterns and Conventions.
- **message rule**: Provide human-readable feedback
  - Should be different for compliant vs. non-compliant cases
  - Clearly explain what was checked and the verdict

**Example:**

```rego
package cch.metrics.incident_reporting_team

import data.cch.compare
import rego.v1
import input as document

default applicable := false
default compliant := false

applicable if {
    document.securityIncident != {}
}

compliant if {
    compare(data.operator, data.target_value, document.securityIncident.team)
}

message := "The policy document defines an incident reporting team." if {
    compliant
} else := "The policy document does not define an incident reporting team." if {
    not compliant
}
```

### Step 4: Update the Ontology

The ontology defines the semantic structures and relationships in the security metrics domain. It is written in OWL/XML format and consists of multiple modular files organized by domain.

**Ontology Files Location:** `ontology/v1/`

**Critical:** Do NOT manually edit `ontology/v1/ontology.proto` or `ontology/v1/ontology-merged.owx` - these are automatically generated.

**Ontology Structure:**

The ontology is organized into core concepts and resource types:

**Core Files** (`ontology/v1/core/`):
- **security.owx** - Security concepts and controls (Encryption, Authentication, Authorization, etc.)
- **functionality.owx** - Security functionalities and features 
- **properties.owx** - Properties and attributes used across resources
- **framework.owx** - Software frameworks, libraries, and cloud platforms (SpringBoot, Jersey, AWS, CircleCI, etc.); also defines common data properties
- **evidence.owx** - Evidence types and structures
- **resource.owx** - Base resource definitions

**Resource Type Files** (`ontology/v1/resource/`):
- **infrastructure.owx** - Infrastructure resources (VirtualMachine, CloudResource, Container, BlockStorage, etc.)
- **document.owx** - Document types (PolicyDocument, ControlDescription, etc.)
- **application.owx** - Application resources (SoftwareApplication, CodeRepository, etc.)
- **governance.owx** - Governance structures and organizational entities
- **hardware.owx** - Hardware resources
- **ml.owx** - Machine Learning models and related concepts
- **product.owx** - Product definitions

**Umbrella Files:**
- **core.owx** - Imports all core files
- **resource.owx** - Imports all resource type files
- **ontology.owx** - Main entry point, imports both core and resource

**Understanding Metrics and Ontology:**

Metrics typically check one of these three things:
1. **A security feature or functionality** attached to a resource (e.g., checking if encryption is enabled on storage)
2. **A resource's own properties** (e.g., checking if a resource exists in a specific location)
3. **A combination** of a resource and its features/functionalities

Security features (Confidentiality, Integrity, Availability, Authentication, etc.) are typically attached to resources to provide security capabilities. Functionalities are non-security-specific capabilities that resources offer.

**Guidance on Adding Ontology Elements:**

When creating a new metric, you typically need to:

1. **Identify the domain concepts** your metric measures
   - Example: A metric about VM public IPs checks a `[VirtualMachine]` resource with `[internetAccessibleEndpoint]` property
   - Example: A metric about incident reporting checks a `[SecurityIncident]` with `[team]` property
   - Example: A metric about backup location checks a `[Backup]` resource and where its output is stored

2. **Select the appropriate file(s) to modify**
   - If your metric checks a security feature → reference or add to `core/security.owx`
   - If your metric checks a functionality → reference or add to `core/functionality.owx`
   - If your metric checks an infrastructure resource → modify `resource/infrastructure.owx`
   - If your metric checks an application resource → modify `resource/application.owx`
   - If your metric checks a governance concept → modify `resource/governance.owx`
   - If your metric references document types → modify `resource/document.owx`

3. **Add or reference ontology classes**
   - If a class already exists, reference it in your metric description (using `[ClassName]` in brackets)
   - If a class doesn't exist, it must be added to the appropriate .owx file
   - Only add classes to `security.owx` if they are general security concepts used across multiple metrics
   - Only add classes to `core/functionality.owx` if they are non-security functionalities

4. **Define properties and relationships**
   - Properties connect classes and describe their attributes (e.g., `SecurityIncident` has a `team` property)
   - Security features and functionalities are typically attached to resources via properties
   - Use consistent naming conventions: camelCase for properties and classes

**Namespace Prefixes and Datatypes for Properties:**

When adding new properties to the ontology, use the correct namespace prefix and datatype:
- **`prop:`** - Use for functional and policy properties (e.g., `prop:isDefined`, `prop:coveredAttackTypes`, `prop:authorizationTypes`)
  - IRI: `https://ontology.cybersecuritycertcluster.eu/properties/`
  - Used for properties that describe features, policies, and functionalities
  - Datatype examples: `xsd:boolean` (for flags like isDefined), `xsd:string` (for single values), `xsd:listString` (for lists of strings)
- **`res:`** - Use for resource/class-related properties (e.g., `res:cve`, `res:name`)
  - IRI: `https://ontology.cybersecuritycertcluster.eu/classes/`
  - Used for low-level properties specific to resources

**Important:** Check existing ontology for list datatypes. For example, use `xsd:listString` for properties that contain multiple string values (see `prop:calls`, `prop:team` for examples).

**How to Edit OWL/XML Files:**

The ontology is best edited using **Protégé**, a dedicated OWL editor:
1. Download Protégé from https://protege.stanford.edu/
2. Open `ontology/v1/ontology.owx` to view the complete ontology
3. Or open individual .owx files to edit specific domains
4. Add new Classes, Properties, or update existing definitions
5. Save and commit changes

**Automatic Generation:**
After editing OWL files and committing:
- `ontology.proto` is automatically regenerated from the .owx files (do not edit manually)
- `ontology-merged.owx` is a merged view of all ontology files

**Example - Adding a Metric:**
For the `VirtualMachinePublicIpDisabled` metric:
- Requires `[VirtualMachine]` class (exists in `infrastructure.owx`)
- Requires `[internetAccessibleEndpoint]` property (exists in `properties.owx`)
- Description references both: "This rule assesses whether a [VirtualMachine] that offers the property [internetAccessibleEndpoint] has [p1:internetAccessibleEndpoint] configured correctly."

## Validation Checklist

Before submitting your metric, verify:

- [ ] Metric folder is named in UpperCamelCase and matches metric name
- [ ] Category folder exists and is named in UpperCamelCase (with capitals for acronyms)
- [ ] Three required files exist: `<MetricName>.yaml`, `metric.rego`, and `data.json`
- [ ] YAML file includes: id (UUID), name, description, implementationGuidelines, category, version, and configuration
- [ ] `id` field is a valid UUID v4
- [ ] YAML `name` matches folder name and filename
- [ ] YAML `category` matches parent directory name
- [ ] YAML `configuration` parameters match fields in `metric.rego`
- [ ] `data.json` mirrors configuration from YAML using snake_case keys
- [ ] `metric.rego` package name uses snake_case metric name
- [ ] `metric.rego` includes all required imports
- [ ] `metric.rego` defines `applicable`, `compliant`, and `message` rules
- [ ] `metric.rego` uses `compare()` function to evaluate configuration parameters
- [ ] All Rego syntax is valid (consider running through Rego linter)
- [ ] Ontology has been updated with new concepts (or noted for future update)
- [ ] If adding new properties: namespace prefixes are consistent (e.g., `prop:` for functional properties used in both `properties.owx` declarations and `functionality.owx` SubClassOf references)
- [ ] No syntax errors in any files (YAML, JSON, Rego, OWL/XML)

## Testing Your Metric

TODO: Add guidance on:
- How to test the Rego policy locally
- How to validate the metric against sample policy documents
- How to debug common issues

## General Patterns and Conventions

### Naming Conventions

- **Metric names**: UpperCamelCase (e.g., `IncidentReportingTeam`, `BootLoggingRetention`)
- **Category names**: UpperCamelCase with capital acronyms (e.g., `AISecurity`, `CSAF`)
- **Rego package names**: snake_case derived from metric name (e.g., `incident_reporting_team`)
- **Variable names in Rego**: lowercase with underscores (e.g., `incident_team`, `encryption_level`)

### Operator Patterns

The framework provides several standard operators for comparing values. See `metrics/operators.rego` for the complete list. Available operators include:

- **==**: Exact equality
- **>=**: Greater than or equal
- **<=**: Less than or equal
- **<**: Less than
- **>**: Greater than
- **isIn**: Value is in the target list (supports strings, numbers, arrays, and object keys)
- **allIn**: All elements of an array are in the target list

### Policy Handling (AMOE Metrics)

For AMOE-related metrics that evaluate policy documents, policies follow a hierarchical structure in the ontology:

**Structure:** `Functionality` → `Policies` → Specific Policy Types (e.g., `DataConfidentialitySDNPolicy`, `LeastPrivilegePolicy`)

**Key concepts:**
- A `[PolicyDocument]` can contain specific policy types (defined in `core/functionality.owx`)
- Each policy type has properties (typically `isDefined: boolean`) indicating presence and configuration
- Metrics evaluate whether policies are defined and their properties meet requirements

**Example hierarchy:**
```
Functionality
  ├─ Policies
  │  ├─ DataConfidentialitySDNPolicy
  │  ├─ LeastPrivilegePolicy
  │  ├─ SeparationOfDutiesPolicy
  │  └─ ... other policies
```

**In metric descriptions:** Reference specific policy types and their properties
- Example: "This rule assesses whether a [PolicyDocument] includes [DataConfidentialitySDNPolicy] with [p1:isDefined] set correctly."


**Example - Adding a Property Beyond `isDefined`:**

If your metric evaluates a policy property beyond the standard `isDefined` boolean:

1. **Declare the property in `properties.owx`** with the appropriate prefix:
```xml
<Declaration>
    <DataProperty abbreviatedIRI="prop:coveredAttackTypes"/>
</Declaration>
```

2. **Add the property to your policy class in `functionality.owx`** using SubClassOf with DataSomeValuesFrom. For list properties, use `xsd:listString`:
```xml
<SubClassOf>
    <Class abbreviatedIRI="core:NetworkThreatMitigationPolicy"/>
    <DataSomeValuesFrom>
        <DataProperty abbreviatedIRI="prop:coveredAttackTypes"/>
        <Datatype abbreviatedIRI="xsd:listString"/>
    </DataSomeValuesFrom>
</SubClassOf>
```

For single-value string properties, use `xsd:string` instead. For lists of other types, look for `xsd:list*` types in the existing ontology (e.g., `dt:listCpgNodes`).

3. **Reference it in your metric description:**
```yaml
description: "This rule assesses whether a [PolicyDocument] includes [NetworkThreatMitigationPolicy] with [p1:coveredAttackTypes] set correctly."
```

Ensure namespace prefixes are consistent across all uses: if you declare a property with `prop:`, reference it with `prop:` everywhere (in functionality.owx SubClassOf declarations and in metric.rego).


### Comment Guidelines

- Use comments sparingly in Rego - well-named rules and clear logic should be self-explanatory
- Only comment non-obvious logic, workarounds, or complex conditions
- In YAML, use the `comments` field for metric-level notes

## Questions and Examples

For detailed examples of metrics, review:
- `metrics/SecurityIncidents/IncidentReportingTeam/` - Simple metric with one parameter
- `metrics/LoggingMonitoring/BootLoggingRetention/` - Metric with specific conditions
- Any metric in `metrics/<Category>/` for reference implementations

## Contributing Process

1. Create your metric following all steps above
2. Run validation checklist
3. Test your metric locally (if testing tools available)
4. Create a pull request with your new metric
5. Update ontology files in the same PR (or note if deferred)
6. Request review from project maintainers

## Questions?

If you encounter issues or have questions while creating a metric:
- Review existing metrics in similar categories
- Check `metrics/operators.rego` for available comparison operators
- Consult the ontology README at `ontology/README.md`
- Open an issue or discussion in the project repository
