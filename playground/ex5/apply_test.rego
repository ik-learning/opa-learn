package example

test_decison_allowed {
    result := decision with input as {
        "user": {
            "id": "abc123"
        },
        "request": {
            "method": "POST",
            "path": "/users"
        }
    }
    print(result)
    print(expectedResult)

    result == expectedResult
}
