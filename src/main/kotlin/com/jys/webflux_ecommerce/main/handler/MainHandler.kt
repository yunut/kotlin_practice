package com.jys.webflux_ecommerce.main.handler

import com.jys.webflux_ecommerce.main.service.MainService
import org.springframework.http.MediaType
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.server.ServerRequest
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.ServerResponse.ok
import reactor.core.publisher.Mono

@Component
class MainHandler(private val mainService: MainService) {

    //Router Handler 연결 테스트
    fun get(serverRequest: ServerRequest): Mono<ServerResponse> = ok()
            .contentType(MediaType.APPLICATION_JSON)
            .body(Mono.just("테스트중 입니다."), String::class.java)
}