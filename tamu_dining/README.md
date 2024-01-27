
REST API, has set of users
/users shows all users
/users/:uin shows specific user
/users/:uin/update_credits/:credits is a patch request to add :credits credits to the user's database information
    ex. /users/123456789/update_credits/6 updates user with uin 123456789 to have 6 more credits than before

    ex. /users/123456789/update_credits/-6 updates user with uin 123456789 to have 6 less credits than before