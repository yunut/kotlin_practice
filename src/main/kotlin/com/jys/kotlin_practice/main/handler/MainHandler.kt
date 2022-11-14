package com.jys.kotlin_practice.main.handler

import com.jys.kotlin_practice.main.service.MainService
import org.springframework.http.MediaType
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.server.ServerRequest
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.ServerResponse.notFound
import org.springframework.web.reactive.function.server.ServerResponse.ok
import reactor.core.publisher.Mono

@Component
class MainHandler(private val mainService: MainService) {
    /**
     * 메인 페이지 출력
     */
    fun main(serverRequest: ServerRequest): Mono<ServerResponse> = ok()
            .contentType(MediaType.TEXT_HTML)
            .render("home/main")
            .switchIfEmpty(notFound().build())
}