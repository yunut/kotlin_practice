package com.jys.kotlin_practice.error

import com.fasterxml.jackson.annotation.JsonInclude
import org.springframework.web.bind.support.WebExchangeBindException
import org.springframework.web.server.ResponseStatusException
import java.time.Instant

@JsonInclude(JsonInclude.Include.NON_EMPTY)
class ErrorResponse private constructor(
    val timestamp: Long = Instant.now().toEpochMilli(),

    /**
     * 에러 코드
     */
    val code: String? = null,

    /**
     * 에러 내용
     */
    val message: String? = null,

    /**
     * Input field 에러 리스트
     */
    val fields: List<SimpleFieldError> = emptyList()
) {
    companion object {
        fun from(exception: WebExchangeBindException) = ErrorResponse(
            message = "잘못된 요청입니다",
            fields = exception.bindingResult.fieldErrors.map { it.toCustomFieldError() }
        )

        fun from(exception: AbstractErrorCodeException) = ErrorResponse(
            code = exception.errorCode,
            message = exception.reason
        )

        fun from(exception: ResponseStatusException) = ErrorResponse(
            message = exception.reason
        )
    }
}
