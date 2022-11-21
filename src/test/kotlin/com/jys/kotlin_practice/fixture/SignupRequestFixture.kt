package com.jys.kotlin_practice.fixture

import com.jys.kotlin_practice.account.SignupRequest

inline fun signupRequest(block: SignupRequestFixtureBuilder.() -> Unit = {}) =
    SignupRequestFixtureBuilder().apply(block).build()

class SignupRequestFixtureBuilder {
    var name: String = "테스터"
    var email: String = "test@test.com"
    var password: String = "test1234!"
    var passwordCheck: String = "test1234!"
    fun build(): SignupRequest = SignupRequest(
        name, email, password, passwordCheck
    )
}
