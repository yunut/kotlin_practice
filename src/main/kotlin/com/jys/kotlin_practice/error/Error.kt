package com.jys.kotlin_practice.error

interface Error {

    val name: String

    val message: String

    val code: String
        get(): String = name.lowercase()
}