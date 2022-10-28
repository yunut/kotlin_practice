package com.jys.webflux_ecommerce.main.repository

import com.jys.webflux_ecommerce.main.document.MainDocument
import org.springframework.data.mongodb.repository.ReactiveMongoRepository
import org.springframework.stereotype.Repository
import reactor.core.publisher.Mono

/*
@Repository
interface MainRepository : ReactiveMongoRepository<MainDocument, String> {
    fun findByBaseId(baseId: String): Mono<MainDocument>
}*/
