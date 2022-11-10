package com.jys.webflux_ecommerce.account.document

import org.springframework.data.annotation.Id
import org.springframework.data.mongodb.core.mapping.Document
import java.time.LocalDateTime

@Document(collection = "account")
data class Account(
    @Id
    var _id: String? = null,
    var name: String,
    var email: String,
    var pw: String,
    var createdAt: LocalDateTime = LocalDateTime.now(),
    var updatedAt: LocalDateTime? = null

)