package com.jys.kotlin_practice.config

import com.jys.kotlin_practice.keycloak.KeycloakClient
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration


@Configuration
class KeycloakConfiguration(
    @Value("\${keycloak.realm}")
    private val realm: String,
    @Value("\${keycloak.grant_type}")
    private val grantType: String,
    @Value("\${keycloak.auth-server-url}")
    private val authUrl: String,
    @Value("\${keycloak.clientId}")
    private val clientId: String,
    @Value("\${keycloak.client_secret}")
    private val clientSecret: String
) {
    /**
     * keycloak client
     */
    @Bean
    fun keycloakClient(): KeycloakClient =
        KeycloakClient(realm, grantType, authUrl, clientId, clientSecret)
}