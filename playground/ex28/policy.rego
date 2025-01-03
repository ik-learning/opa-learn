package envoy.authz

# https://www.openpolicyagent.org/docs/latest/envoy-primer/

import input.attributes.request.http

default allow := false

allow if {
	is_token_valid
	action_allowed
}

is_token_valid if {
	token.valid
	now := time.now_ns() / 1000000000
	token.payload.nbf <= now
	now < token.payload.exp
}

action_allowed if {
	http.method == "GET"
	token.payload.role == "guest"
	glob.match("/people/*", ["/"], http.path)
}

action_allowed if {
	http.method == "GET"
	token.payload.role == "admin"
	glob.match("/people/*", ["/"], http.path)
}

action_allowed if {
	http.method == "POST"
	token.payload.role == "admin"
	glob.match("/people", ["/"], http.path)
	lower(input.parsed_body.firstname) != base64url.decode(token.payload.sub)
}

token := {"valid": valid, "payload": payload} if {
	[_, encoded] := split(http.headers.authorization, " ")
	[valid, _, payload] := io.jwt.decode_verify(encoded, {"secret": "secret"})
}
