package com.jys.kotlin_practice.config

import com.jys.kotlin_practice.keycloak.KeycloakClient
import com.jys.kotlin_practice.keycloak.KeycloakProperties
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration


@Configuration
@EnableConfigurationProperties(value = [KeycloakProperties::class])
class KeycloakConfiguration {
    /**
     * keycloak client
     */
    @Bean
    fun keycloakClient(keycloakProperties: KeycloakProperties): KeycloakClient =
        KeycloakClient(keycloakProperties)
}