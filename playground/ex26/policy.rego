# https://stackoverflow.com/questions/71420104/opa-authorization-policies-with-scopes-and-roles?rq=1
package whatever.authz

context_scope == data["attributes"][principal_role][_]

# context_scope := concat(":", [input.context.action, input.context.resource])
context_scope = data["attributes"][principal_role][_]

default allow = false

allow if {
	token_has_context_scope
	principal_has_resource_access
}

token_has_context_scope if {
	context_scope == input.token.scopes[_]
}

principal_has_resource_access if {
	principal_role := input.principal.roles[_]
	context_scope == data[principal_role][_]
}
