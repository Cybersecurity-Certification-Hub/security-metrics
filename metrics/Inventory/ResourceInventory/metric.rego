package metrics.inventory.resource_inventory

import data.compare
import rego.v1

default applicable = false

default compliant = false

applicable = true

# all resources are applicable

compliant = true

# all resources are automatically compliant once we registered an evidence for them
