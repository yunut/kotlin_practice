package com.jys.kotlin_practice

import com.jys.kotlin_practice.main.handler.MainHandler
import com.jys.kotlin_practice.main.router.MainRouter
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.web.reactive.server.WebTestClient

@SpringBootTest(
        classes = [
            MainHandler::class,
            MainRouter::class,
        ]
)

class MainHandlerTest {

    private lateinit var client: WebTestClient

    @Autowired
    private lateinit var mainRouter: MainRouter

    @BeforeEach
    fun beforeTest() {
        client = WebTestClient
                .bindToRouterFunction(mainRouter.router())
                .build()
    }

    @Test
    fun mainHanderTest() {
        client.get()
                .uri("/")
                .exchange()
                .expectStatus().isOk
                .expectBody(String::class.java)
                .value {value -> Assertions.assertEquals(value, "테스트중 입니다.")}
    }

    @Test
    fun notFoundHandlerMappingTest() {
        client.get()
                .uri("/wrong")
                .exchange()
                .expectStatus().is4xxClientError
    }
}