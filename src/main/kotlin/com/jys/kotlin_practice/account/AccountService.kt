package com.jys.kotlin_practice.account

import com.jys.kotlin_practice.account.error.ErrorMessage
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service

@Service
class AccountService {


    fun signup(accountRequest: AccountRequest): ResponseEntity<AccountResponse> {
        // 비밀번호 유효성 검증
        if(accountRequest.password != accountRequest.passwordCheck) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(AccountResponse(ErrorMessage.PASSWORD_CHECK_NOT_MATCH))
        }

        return ResponseEntity.status(HttpStatus.CREATED).build<AccountResponse>()
    }
}