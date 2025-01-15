# https://github.com/open-policy-agent/opa/issues/2755

default jwt_exists = false
jwt_exists {
  count(jwt_exists_a) > 0
}
jwt_exists_a[r] {
  regex.match(`^[A-Za-z0-9-_=]+\.[A-Za-z0-9-_=]+\.?[A-Za-z0-9-_.+/=]*$`, sso_jwt)
  r := "input.sso_jwt contains a syntactically valid jwt"
}
jwt_exists_d[r] {
  not jwt_exists
  r := "input.sso_jwt did not contain a syntactically valid jwt"
}

# Decode the jwt contained in input.sso_jwt
default jwt = null
jwt = t {
  jwt_exists
  [_, payload, _] = io.jwt.decode(sso_jwt)
  t := {
    "payload": payload
  }
}

# check if the jwt is signed
default jwt_is_signed = false
jwt_is_signed {
  count(jwt_is_signed_a) > 0
}
jwt_is_signed_a[r] {
  jwt_exists
  custom_builtin_verify_jwt(api_host, sso_jwt)
  r := {"input.sso_jwt is signed"} | jwt_exists_a
}
jwt_is_signed_d[r] {
  not jwt_is_signed
  r := {"input.sso_jwt is not signed"} | jwt_exists_d
}

# get employee information in the jwt payload
default employee = null
employee = e {
  count(employee_a) > 0
  e := {
    "username": jwt.payload.username
  }
}
employee_a[r] {
  jwt_is_signed
  jwt_has_expected_prop_2
  jwt_has_expected_prop_3
  r := {"jwt represents an employee"} | jwt_is_signed_a | jwt_has_expected_prop_2_a | jwt_has_expected_prop_3_a
}
employee_d[r] {
  is_null(employee)
  r := {"jwt does not represent an employee"} | jwt_is_signed_d | jwt_has_expected_prop_2_d | jwt_has_expected_prop_3_d
}

# check if the jwt has not exceeded its ttl
default jwt_is_fresh = false
jwt_is_fresh {
  count(jwt_is_fresh_a) > 0
}
jwt_is_fresh_a[r] {
  (round(time.now_ns() / 1e9) - jwt.payload.iat) < max_ttl
  r := "jwt is fresh"
}
jwt_is_fresh_d[r] {
  not jwt_is_fresh
  r := "jwt is not fresh"
}

# can we do a thing
default can_do_thing = false
can_do_thing {
  count(can_do_thing_a) > 0
}
can_do_thing_a[r] {
  not is_null(employee)
  jwt_is_fresh
  r := employee_a | jwt_is_fresh_a
}
can_do_thing_d[r] {
  not can_do_thing
  r := employee_d | jwt_is_fresh_d
}
