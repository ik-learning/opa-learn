# https://play.openpolicyagent.org/p/QUNnPpZU44
package play

permit[permission] {
	is_workforce
	input.role == "admin"
	permission = getPermission(input.role)
}

permit[permission] {
	not is_workforce
	input.role == "expert"
	permission = getPermission(input.role)
}

is_workforce {
	input.nsId == "50000000"
}

getPermission(role) = permission {
	permission := data.permissionList[role]
}

permissionList := {
	"admin": "allPermission",
	"expert": "reviewPermission",
}

test_Permit {
	count(permit) == 1 with input as {
		"nsId": "50000000",
		"role": "admin",
	}
}

test_Not_Permit {
	count(permit) == 0 with input as {
		"nsId": "50000000",
		"role": "developer",
	}
}

test_Permissions {
	permit == {"reviewPermission"} with input as {"role": "expert"}
}

test_Permit_developer {
	count(getPermission("developer")) > 0 with data.permissionList as {"developer": "test"}
}
