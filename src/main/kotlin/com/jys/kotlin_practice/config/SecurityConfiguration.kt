package com.jys.kotlin_practice.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity
import org.springframework.security.config.web.server.ServerHttpSecurity
import org.springframework.security.web.server.SecurityWebFilterChain

@Configuration
@EnableWebFluxSecurity
class SecurityConfiguration {

    /**
     * csrf 비활성화
     * path-matcher 허용
     */
    @Bean
    fun webHttpSecurity(http: ServerHttpSecurity): SecurityWebFilterChain =
        http.csrf().disable().authorizeExchange {
            it.pathMatchers("/account/signin").permitAll()
            it.pathMatchers("/account/signup").permitAll()
            it.pathMatchers("/account/profile").permitAll()
            it.pathMatchers("/css/**").permitAll()
            it.pathMatchers("/js/**").permitAll()
        }.oauth2ResourceServer { it.opaqueToken {  } }.build()
}