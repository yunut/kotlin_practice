package com.jys.kotlin_practice.keycloak

import org.keycloak.admin.client.KeycloakBuilder
import org.keycloak.admin.client.resource.RealmResource

class KeycloakClient(
    private val realm: String,
    private val grantType: String,
    private val authUrl: String,
    private val clientId: String,
    private val clientSecret: String
) {
    fun build(): RealmResource =
        KeycloakBuilder.builder()
            .realm(realm)
            .grantType(grantType)
            .serverUrl(authUrl)
            .clientId(clientId)
            .clientSecret(clientSecret)
            .build().realm(realm)
}