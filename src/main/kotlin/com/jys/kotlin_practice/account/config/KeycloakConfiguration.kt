package com.jys.kotlin_practice.account.config

import org.keycloak.OAuth2Constants
import org.keycloak.adapters.springboot.KeycloakSpringBootConfigResolver
import org.keycloak.admin.client.Keycloak
import org.keycloak.admin.client.KeycloakBuilder
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration


@Configuration
class KeycloakConfiguration(
    @Value("\${keycloak.credentials.secret}")
    private val secretKey: String,
    @Value("\${keycloak.resource}")
    private val clientId: String,
    @Value("\${keycloak.auth-server-url}")
    private val authUrl: String,
    @Value("\${keycloak.realm}")
    private val realm: String
) {

    /**
     * keycloak.json 대신에 Spring Boot yml 파일을 이용해 구성
     */
    @Bean
    fun keycloakConfigResolver(): KeycloakSpringBootConfigResolver? {
        return KeycloakSpringBootConfigResolver()
    }

    @Bean
    fun keycloak(): Keycloak {
        return KeycloakBuilder.builder()
            .grantType(OAuth2Constants.PASSWORD)
            .serverUrl(authUrl)
            .realm(realm)
            .clientId(clientId)
            .username("admin")
            .password("admin")
            .build()
    }
}