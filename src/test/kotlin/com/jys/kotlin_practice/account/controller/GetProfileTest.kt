package com.jys.kotlin_practice.account.controller

import io.kotest.core.spec.style.BehaviorSpec
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.web.reactive.server.WebTestClient
import org.springframework.security.test.web.reactive.server.SecurityMockServerConfigurers.mockOpaqueToken

@SpringBootTest
@AutoConfigureWebTestClient
class GetProfileTest(
    private val webTestClient: WebTestClient
) : BehaviorSpec({
    val path = "/account/profile"
    val customerId = "customerId"

    Given("인증 요청 이전") {
        When("인증이 올바르지 않은 경우") {
            val exchange = webTestClient.get().uri(path).exchange()
            Then("401 Unauthorized") {
                exchange.expectStatus().isUnauthorized
            }
        }
    }

    Given("인증 요청 이후") {
        When("인증이 올바르지 않은 경우") {
            val exchange = webTestClient
                .mutateWith(mockOpaqueToken().attributes {
                    it["sub"] = customerId
                })
                .get().uri(path).exchange()

            Then("200 Ok") {
                exchange.expectStatus().isOk
            }
        }
    }
})