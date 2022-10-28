package com.jys.webflux_ecommerce.main.router

import com.jys.webflux_ecommerce.main.handler.MainHandler
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.reactive.function.server.router

@Configuration
class MainRouter(private val handler: MainHandler) {

    @Bean
    fun routerFunction() =
            router {
                "v1".nest {
                    listOf(
                            GET("/main", handler::get)
                    )
                }
            }

}