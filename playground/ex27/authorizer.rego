package authorizer

default username := null

decode_user(jwt) := user_id {
    // logic to decode token & return user_id
}
