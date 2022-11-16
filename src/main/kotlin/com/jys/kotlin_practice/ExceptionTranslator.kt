package com.jys.kotlin_practice

import com.jys.kotlin_practice.error.AbstractErrorCodeException
import com.jys.kotlin_practice.error.ErrorResponse
import org.slf4j.LoggerFactory
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice
import org.springframework.web.bind.support.WebExchangeBindException
import org.springframework.web.server.ResponseStatusException

@RestControllerAdvice
class ExceptionTranslator {
    private val log = LoggerFactory.getLogger(javaClass)

    /**
     * 다중 필드 예외 발생시 에러 응답 처리
     */
    @ExceptionHandler(WebExchangeBindException::class)
    fun handleWebExchangeBindException(exception: WebExchangeBindException): ResponseEntity<ErrorResponse> {
        log.debug("WebExchangeBindException", exception)
        return ResponseEntity
            .badRequest()
            .contentType(MediaType.APPLICATION_JSON)
            .body(ErrorResponse.from(exception))
    }

    /**
     * custom code 예외 발생시 에러 응답처리
     */
    @ExceptionHandler(AbstractErrorCodeException::class)
    fun handleErrorCodeException(exception: AbstractErrorCodeException): ResponseEntity<ErrorResponse> {
        log.debug("AbstractErrorCodeException", exception)
        return ResponseEntity
            .status(exception.status)
            .contentType(MediaType.APPLICATION_JSON)
            .body(ErrorResponse.from(exception))
    }

    /**
     * response status 기반 예외 발생시 에러 응답 처리
     */
    @ExceptionHandler(ResponseStatusException::class)
    fun handleResponseStatusException(exception: ResponseStatusException): ResponseEntity<ErrorResponse> {
        log.debug("ResponseStatusException", exception)
        return ResponseEntity
            .status(exception.status)
            .contentType(MediaType.APPLICATION_JSON)
            .body(ErrorResponse.from(exception))
    }

    /**
     * 정의되지 않은 예외 발생시 에러 응답 처리
     */
    @ExceptionHandler(Exception::class)
    fun handleException(exception: Exception): ResponseEntity<ErrorResponse> {
        log.error("Unhandled exception", exception)
        return ResponseEntity
            .internalServerError()
            .contentType(MediaType.APPLICATION_JSON).build()
    }
}
