package com.jys.kotlin_practice.account

import com.jys.kotlin_practice.account.error.AccountError
import com.jys.kotlin_practice.error.BadRequestErrorCodeException
import org.springframework.stereotype.Service

@Service
class AccountService {

    /**
     * 회원 가입
     * @param signupRequest 회원가입 요청 데이터
     */
    fun signup(signupRequest: SignupRequest) {
        // 비밀번호 유효성 검증
        if(signupRequest.password != signupRequest.passwordCheck) throw BadRequestErrorCodeException(AccountError.DIFFERENT_PASSWORD)
        // TODO keycloak-admin-client 로 회원가입 요청
    }
}