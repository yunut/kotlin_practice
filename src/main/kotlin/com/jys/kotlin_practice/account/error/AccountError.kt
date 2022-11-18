package com.jys.kotlin_practice.account.error

import com.jys.kotlin_practice.error.Error

enum class AccountError(
    private val message: String
) : Error {
    DIFFERENT_PASSWORD("비밀번호가 일치하지 않습니다");

    override fun code(): String = this.name.lowercase()

    override fun message(): String = this.message
}
