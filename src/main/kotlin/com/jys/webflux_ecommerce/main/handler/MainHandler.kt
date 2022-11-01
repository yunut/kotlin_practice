package com.jys.webflux_ecommerce.main.handler

import com.jys.webflux_ecommerce.main.service.MainService
import org.springframework.http.MediaType
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.server.ServerRequest
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.ServerResponse.notFound
import org.springframework.web.reactive.function.server.ServerResponse.ok
import reactor.core.publisher.Mono

@Component
class MainHandler(private val mainService: MainService) {
    //Router Handler 연결 테스트
    fun main(serverRequest: ServerRequest): Mono<ServerResponse> = ok()
            .contentType(MediaType.TEXT_HTML)
            .render("home/main")
            .switchIfEmpty(notFound().build())
}