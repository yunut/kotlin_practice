package com.jys.kotlin_practice.account


import javax.validation.constraints.Email
import javax.validation.constraints.NotBlank

data class AccountRequest(

    @field: NotBlank(message = "이름은 필수 입력 값입니다.")
    val name: String,

    @field: NotBlank(message = "이메일은 필수 입력 값입니다.")
    @field: Email(message = "이메일 형식이 맞지 않습니다.")
    val email: String,

    @field: NotBlank(message = "비밀번호는 필수 입력 값입니다.")
    val password: String,

    @field: NotBlank(message = "비밀번호 확인은 필수 입력 값입니다.")
    val passwordCheck: String
)