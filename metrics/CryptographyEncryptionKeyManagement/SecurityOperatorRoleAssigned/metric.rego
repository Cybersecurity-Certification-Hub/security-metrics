package cch.metrics.security_operator_role_assigned

import data.cch.compare
import rego.v1
import input as assignments

default applicable = false

default compliant = false

applicable if {
    users := security_operator_assigned_users_source
    users != null
}

compliant if {
    assigned := security_operator_role_assigned
    compare(data.operator, data.target_value, assigned)
}

applicable if {
    _ := security_operator_role_flag
}

security_operator_role_flag := flag if {
    flag := object.get(assignments, "securityOperatorRoleAssigned", null)
    flag != null
}

security_operator_assigned_users_source := users if {
    users := object.get(assignments, "securityOperatorAssignedUsers", null)
}

security_operator_assigned_users := users if {
    users := security_operator_assigned_users_source
    users != null
}

security_operator_role_assigned := true if {
    users := security_operator_assigned_users
    is_array(users)
    count(users) > 0
}

security_operator_role_assigned := false if {
    users := security_operator_assigned_users
    is_array(users)
    count(users) == 0
}

security_operator_role_assigned := true if {
    users := security_operator_assigned_users
    is_object(users)
    count(object.keys(users)) > 0
}

security_operator_role_assigned := false if {
    users := security_operator_assigned_users
    is_object(users)
    count(object.keys(users)) == 0
}

# Fallback to explicit boolean flag if user assignments are not available.
security_operator_role_assigned := flag if {
    users := security_operator_assigned_users_source
    users == null
    flag := security_operator_role_flag
}
