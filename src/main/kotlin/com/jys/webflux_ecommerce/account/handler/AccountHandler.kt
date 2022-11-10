package com.jys.webflux_ecommerce.account.handler

import com.jys.webflux_ecommerce.account.document.Account
import com.jys.webflux_ecommerce.account.service.AccountService
import org.springframework.http.MediaType
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.server.ServerRequest
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.ServerResponse.notFound
import org.springframework.web.reactive.function.server.ServerResponse.ok
import org.springframework.web.reactive.function.server.body
import reactor.core.publisher.Mono
import java.util.Objects

@Component
class AccountHandler(private val accountService: AccountService) {
    /**
     * 사용자 목록 출력
     */
    fun getAllUser(request: ServerRequest): Mono<ServerResponse> = ok()
            .contentType(MediaType.APPLICATION_JSON)
            .body<Account>(accountService.getAll())
            .switchIfEmpty(ServerResponse.notFound().build())

    /**
     * 사용자 추가
     */
    fun saveUser(request: ServerRequest): Mono<ServerResponse> = ok()
            .contentType(MediaType.APPLICATION_JSON)
            .body(request.bodyToMono(Account::class.java)
                    .switchIfEmpty(Mono.empty())
                    .filter(Objects::nonNull)
                    .flatMap {
                        account ->
                        Mono.fromCallable {
                            accountService.save(account)
                        }.then(Mono.just(account))
                    }
            ).switchIfEmpty(ServerResponse.notFound().build())
}