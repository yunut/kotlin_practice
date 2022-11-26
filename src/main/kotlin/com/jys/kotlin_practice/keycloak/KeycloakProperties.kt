package com.jys.kotlin_practice.keycloak

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.boot.context.properties.ConstructorBinding

@ConstructorBinding
@ConfigurationProperties(prefix = "keycloak")
data class KeycloakProperties(
    val realm: String,
    val grantType: String,
    val authServerUrl: String,
    val clientId: String,
    val clientSecret: String
)