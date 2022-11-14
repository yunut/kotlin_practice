package com.jys.kotlin_practice.account.controller

import com.jys.kotlin_practice.account.dto.AccountPayload
import com.jys.kotlin_practice.account.service.AccountService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping(value = ["/account"])
class AccountController(private val accountService: AccountService) {


    /**
     * 사용자 목록 출력
     */
    @GetMapping(value = ["/list"])
    fun getAllUser() = accountService.getAll()

    /**
     * 사용자 생성
     */
    @PostMapping(value = ["/create"])
    suspend fun createUser(@RequestBody accountRequest: AccountPayload) {
        accountService.saveAccount(accountRequest)
    }

}