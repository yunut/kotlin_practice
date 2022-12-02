package com.jys.kotlin_practice.account

import com.jys.kotlin_practice.account.error.AccountError
import com.jys.kotlin_practice.error.BadRequestErrorCodeException
import com.jys.kotlin_practice.keycloak.KeycloakClient
import org.springframework.stereotype.Service

@Service
class AccountService (
    private val keycloakClient: KeycloakClient
) {
    /**
     * 회원 가입
     * @param signupRequest 회원가입 요청 데이터
     */
    fun signup(signupRequest: SignupRequest) {
        // 비밀번호 유효성 검증
        if(signupRequest.password != signupRequest.passwordCheck) throw BadRequestErrorCodeException(AccountError.DIFFERENT_PASSWORD)

        // 사용자 존재 여부 검증
        if(keycloakClient.searchByEmail(signupRequest.email) == null) throw BadRequestErrorCodeException(AccountError.EMAIL_EXIST)

        keycloakClient.registerBy(signupRequest)
    }
}