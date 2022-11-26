package com.jys.kotlin_practice.account.error

import com.jys.kotlin_practice.error.Error

enum class AccountError(override val message: String) : Error {
    DIFFERENT_PASSWORD("비밀번호가 일치하지 않습니다"),
    EMAIL_EXIST("사용중인 이메일 입니다")
}
