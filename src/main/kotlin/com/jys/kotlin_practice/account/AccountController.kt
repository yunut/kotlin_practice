package com.jys.kotlin_practice.account

import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import javax.validation.Valid

@RestController
@RequestMapping(value = ["/account"])
class AccountController(private val accountService: AccountService) {

    /**
     * 회원가입
     */
    @PostMapping(value = ["/signup"])
    fun signup(@Valid @RequestBody accountRequest: AccountRequest): Any {
        return accountService.signup(accountRequest)
    }
}