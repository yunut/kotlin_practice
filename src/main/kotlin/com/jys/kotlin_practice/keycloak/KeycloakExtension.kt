package com.jys.kotlin_practice.keycloak

import com.jys.kotlin_practice.account.SignupRequest
import org.keycloak.representations.idm.CredentialRepresentation
import org.keycloak.representations.idm.UserRepresentation

/**
 * keycloak user 데이터 생성
 * @param request 회원 가입 요청
 */
fun createUserBy(request: SignupRequest) = UserRepresentation().apply {
    this.email = request.email
    this.username = request.email
    this.isEmailVerified = true
    this.isEnabled = true
    this.attributes = mapOf(
        "name" to listOf(request.name)
    )
    this.credentials = listOf(
        CredentialRepresentation().apply {
            this.isTemporary = false
            this.type = CredentialRepresentation.PASSWORD
            this.value = request.password
        }
    )
}