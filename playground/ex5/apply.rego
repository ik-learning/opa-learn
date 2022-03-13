package example

allow {
    print(input.user.email, input.user.roles)
    input.user.roles[_] == "admin"
    endswith(input.user.email, "@acmecorp.com")
}
