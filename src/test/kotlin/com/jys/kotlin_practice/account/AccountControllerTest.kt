package com.jys.kotlin_practice.account

import io.kotest.core.spec.style.BehaviorSpec
import io.mockk.clearAllMocks
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.web.reactive.server.WebTestClient

@SpringBootTest
@AutoConfigureWebTestClient
class AccountControllerTest(
    private val webTestClient: WebTestClient
) : BehaviorSpec({

    beforeEach {
        clearAllMocks()
    }

    Given("회원가입 API 가입 성공") {
        val accountRequest = AccountRequest(
            "테스트",
            "test@test.com",
        "1234",
            "1234"
        )
        When("계정이 만들어졌을 경우") {
            val response = webTestClient.post()
                .uri("/account/signup")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(accountRequest)
                .exchange()

            Then("status: 201 Created") {
                response.expectStatus().isCreated
            }
        }
    }

    Given("회원가입 API 비밀번호 확인 유효성 검사 실패") {
        val accountRequest = AccountRequest(
            "테스트",
            "test@test.com",
            "1234",
            "12"
        )
        When("계정이 만들어졌을 경우") {
            val response = webTestClient.post()
                .uri("/account/signup")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(accountRequest)
                .exchange()

            Then("status: 400 Bad Request") {
                response.expectStatus().isBadRequest
            }
        }
    }

    Given("회원가입 API 이메일 유효성 검사 실패") {
        val accountRequest = AccountRequest(
            "테스트",
            "testasdf",
            "1234",
            "1234"
        )
        When("계정이 만들어졌을 경우") {
            val response = webTestClient.post()
                .uri("/account/signup")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(accountRequest)
                .exchange()

            Then("status: 400 Bad Request") {
                response.expectStatus().isBadRequest
            }
        }
    }
})