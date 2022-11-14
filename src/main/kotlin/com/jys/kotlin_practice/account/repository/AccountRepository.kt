package com.jys.kotlin_practice.account.repository

import com.jys.kotlin_practice.account.document.Account
import org.springframework.data.repository.kotlin.CoroutineSortingRepository
import org.springframework.stereotype.Repository

@Repository
interface AccountRepository : CoroutineSortingRepository<Account?, String?>{
}