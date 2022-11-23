package com.jys.kotlin_practice.keycloak

import org.keycloak.admin.client.Keycloak
import org.keycloak.admin.client.KeycloakBuilder

class KeycloakClient(
    private val realm: String,
    private val grantType: String,
    private val authUrl: String,
    private val clientId: String,
    private val clientSecret: String
) {
    fun build(): Keycloak =
        KeycloakBuilder.builder()
            .realm(realm)
            .grantType(grantType)
            .serverUrl(authUrl)
            .clientId(clientId)
            .clientSecret(clientSecret)
            .build()
}