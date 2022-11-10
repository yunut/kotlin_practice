package com.jys.webflux_ecommerce.account.router

import com.jys.webflux_ecommerce.account.handler.AccountHandler
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.reactive.function.server.router

@Configuration
class AccountRouter(private val handler: AccountHandler) {

    @Bean
    fun account() =
            router {
                GET("/userlist", handler::getAllUser)
                PUT("/useradd", handler::saveUser)
            }

}