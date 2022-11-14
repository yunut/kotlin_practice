package com.jys.kotlin_practice.account.service

import com.jys.kotlin_practice.account.document.Account
import com.jys.kotlin_practice.account.dto.AccountPayload
import com.jys.kotlin_practice.account.repository.AccountRepository
import kotlinx.coroutines.flow.Flow
import org.springframework.stereotype.Service

@Service
class AccountService(private val accountRepository: AccountRepository) {

    fun getAll(): Flow<Account?> {
        return accountRepository.findAll()
    }

    suspend fun saveAccount(accountRequest: AccountPayload): Account? {
        val account = Account.create(accountRequest)
        return accountRepository.save(account)
    }
}