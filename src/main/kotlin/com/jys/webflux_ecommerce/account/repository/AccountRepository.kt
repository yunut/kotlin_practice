package com.jys.webflux_ecommerce.account.repository

import com.jys.webflux_ecommerce.account.document.Account
import org.springframework.data.mongodb.repository.MongoRepository
import org.springframework.data.mongodb.repository.ReactiveMongoRepository
import org.springframework.stereotype.Repository

@Repository
interface AccountRepository : ReactiveMongoRepository<Account?, Long?>{
}