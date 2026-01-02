package cch.metrics.security_administrator_role_assigned

import data.cch.compare
import rego.v1
import input as assignments

default applicable = false

default compliant = false

applicable if {
    security_administrator_assigned_users_available
}

applicable if {
    flag := security_administrator_role_flag
    flag == true
}

applicable if {
    flag := security_administrator_role_flag
    flag == false
}

compliant if {
    assigned := security_administrator_role_assigned
    compare(data.operator, data.target_value, assigned)
}

security_administrator_assigned_users := users if {
    users := object.get(assignments, "securityAdministratorAssignedUsers", null)
    users != null
}

security_administrator_assigned_users_available if {
    security_administrator_assigned_users
}

security_administrator_role_flag := flag if {
    flag := object.get(assignments, "securityAdministratorRoleAssigned", null)
    flag != null
}

security_administrator_role_assigned := true if {
    users := security_administrator_assigned_users
    is_array(users)
    count(users) > 0
}

security_administrator_role_assigned := false if {
    users := security_administrator_assigned_users
    is_array(users)
    count(users) == 0
}

security_administrator_role_assigned := true if {
    users := security_administrator_assigned_users
    is_object(users)
    count(object.keys(users)) > 0
}

security_administrator_role_assigned := false if {
    users := security_administrator_assigned_users
    is_object(users)
    count(object.keys(users)) == 0
}

# Fallback to explicit boolean flag if user assignments are not available.
security_administrator_role_assigned := flag if {
    not security_administrator_assigned_users_available
    flag := security_administrator_role_flag
}
