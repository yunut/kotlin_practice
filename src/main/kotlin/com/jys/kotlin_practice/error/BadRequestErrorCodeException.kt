package com.jys.kotlin_practice.error

import org.springframework.http.HttpStatus

class BadRequestErrorCodeException(error: Error) :
    AbstractErrorCodeException(HttpStatus.BAD_REQUEST, error.message(), error.code())