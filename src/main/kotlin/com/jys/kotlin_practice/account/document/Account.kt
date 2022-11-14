package com.jys.kotlin_practice.account.document

import com.jys.kotlin_practice.account.dto.AccountPayload
import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document
import java.time.LocalDateTime

@Document
data class Account(
    @Id
    var id: String? = null,
    var name: String,
    var email: String,
    var pw: String,
    var address: String? = null,
    var createdAt: LocalDateTime = LocalDateTime.now(),
    var updatedAt: LocalDateTime? = null
) {
    companion object {
        fun create(accountRequest: AccountPayload) = Account(
                name = accountRequest.name,
                email = accountRequest.email,
                pw = accountRequest.pw
        )
    }


}