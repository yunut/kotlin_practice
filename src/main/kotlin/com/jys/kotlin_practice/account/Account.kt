package com.jys.kotlin_practice.account

import org.keycloak.representations.idm.CredentialRepresentation
import org.keycloak.representations.idm.UserRepresentation

data class Account(
    var userName: String,
    var email: String,
    var password: String
) {

    fun create(): UserRepresentation {
        val password = preparePasswordRepresentation(password)
        return prepareUserRepresentation(email, email, password)
    }

    private fun preparePasswordRepresentation(
        password: String
    ): CredentialRepresentation {
        val cR = CredentialRepresentation()
        cR.isTemporary = false
        cR.type = CredentialRepresentation.PASSWORD
        cR.value = password
        return cR
    }

    private fun prepareUserRepresentation(
        userName: String,
        email: String,
        cR: CredentialRepresentation
    ): UserRepresentation {
        val newUser = UserRepresentation()
        newUser.username = userName
        newUser.email = email
        newUser.credentials = listOf(cR)
        newUser.isEnabled = true
        return newUser
    }
}