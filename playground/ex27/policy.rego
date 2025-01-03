package user

import data.authorizer.*

default allow := false

user_id := x {
    x := decode_user(input.jwt)
}

allow := true {
    user_id != null
}
