package com.jys.webflux_ecommerce.account.service

import com.jys.webflux_ecommerce.account.document.Account
import com.jys.webflux_ecommerce.account.repository.AccountRepository
import org.springframework.stereotype.Service
import reactor.core.publisher.Flux
import reactor.core.publisher.Mono

@Service
class AccountService(private val accountRepository: AccountRepository) {

    fun getAll(): Flux<Account?> {
        return accountRepository.findAll()
    }

    fun save(account: Account): Mono<Account> {
        return accountRepository.save(account);
    }
}