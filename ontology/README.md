# CertGraph Ontology

This repository contains the *CertGraph* ontology, which is described in OWL and stored as OWL/XML files.

## Requirments

* Protégé to view and edit the ontology. Protégé can be downloaded from [here](https://protege.stanford.edu/).

## Recommended workflow for viewing and developing the ontology

* Open ontology.owx to view the whole ontology.
* If only certain parts are to be viewed or edited, the respective owx can also be opened on its own.

Note: When opening the ontology, Protégé might display prompts to resolve imports between ontologies.

## Recommended workflow for instantiating the ontology

1. In Protégé, create a new ontology file.
2. Import core.owx using the Imported Ontologies view.
3. Import relevant extensions from the resource folder or all of them by importing resource.owx.
4. Created instances will be stored in the newly created ontology file.

## Ontology Overview
The CertGraph ontology models key concepts and relationships relevant to certificate and security management. It is modular and can be extended with additional domain-specific resources as needed.

### Security Features
The ontology covers the following security features, which are commonly referenced in security and compliance contexts:

| Security Feature   | Explanation                                                                                                    |
|--------------------|---------------------------------------------------------------------------------------------------------------|
| **Auditing**       | Ensures traceability and logging of activities to enable later reviews and analysis. Includes logs, event and access monitoring. |
| **Authenticity**   | Ensures that people, systems, or data are genuinely who or what they claim to be. Includes authentication, digital signatures, and certificates. |
| **Authorization**  | Controls and verifies which actions or access rights are granted to users or systems. Includes role-based access control, permissions, and access lists. |
| **Availability**   | Guarantees that systems and data are reliably accessible and usable at all times. Includes backups, redundancy, DDoS protection, and disaster recovery. |
| **Confidentiality**| Protects data from unauthorized access so that only authorized parties can view sensitive information. Includes encryption and access restrictions. |
| **Integrity**      | Ensures that data and systems remain correct and unaltered, and that any manipulations are detected. Includes checksums, hashes, and digital signatures. |
| **Reliability**    | Ensures the reliability and stability of systems and processes so that they function correctly even in case of errors or failures. Includes automatic updates, monitoring, and fault tolerance. |
