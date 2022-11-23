package com.jys.kotlin_practice.account

import com.jys.kotlin_practice.account.error.AccountError
import com.jys.kotlin_practice.error.BadRequestErrorCodeException
import org.keycloak.admin.client.Keycloak
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Service

@Service
class AccountService (
    private val keycloak: Keycloak,
    @Value("\${keycloak.realm}")
    private val realm: String
) {

    /**
     * 회원 가입
     * @param signupRequest 회원가입 요청 데이터
     */
    fun signup(signupRequest: SignupRequest) {
        // 비밀번호 유효성 검증
        if(signupRequest.password != signupRequest.passwordCheck) throw BadRequestErrorCodeException(AccountError.DIFFERENT_PASSWORD)

        // 사용자 존재 여부 검증
        val account = Account(signupRequest.name, signupRequest.email, signupRequest.password).create()

        //keycloak-admin-client 로 회원가입 요청
        keycloak.realm(realm).users().create(account)
    }
}