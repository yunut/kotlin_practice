package com.jys.kotlin_practice.sample

import io.kotest.core.spec.style.BehaviorSpec
import io.mockk.clearAllMocks
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.web.reactive.server.WebTestClient

@SpringBootTest
@AutoConfigureWebTestClient
class SampleControllerTest(
    private val webTestClient: WebTestClient
) : BehaviorSpec({

    beforeEach {
        clearAllMocks()
    }

    Given("web-test-client 예제") {
        When("api 경로가 없는 경우") {
            val response = webTestClient.post()
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(
                    mapOf("a" to "b")
                ).exchange()

            Then("status: 404 Not Found") {
                response.expectStatus().isNotFound
            }
        }
    }

})