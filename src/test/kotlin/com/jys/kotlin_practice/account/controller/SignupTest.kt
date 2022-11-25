package com.jys.kotlin_practice.account.controller

import com.jys.kotlin_practice.account.SignupRequest
import com.jys.kotlin_practice.account.error.AccountError
import com.jys.kotlin_practice.error.ErrorResponse
import com.jys.kotlin_practice.fixture.signupRequest
import com.jys.kotlin_practice.keycloak.KeycloakClient
import io.kotest.core.spec.style.BehaviorSpec
import io.kotest.inspectors.forAll
import io.kotest.matchers.should
import io.kotest.matchers.shouldBe
import io.kotest.matchers.shouldNotBe
import io.mockk.*
import org.keycloak.admin.client.resource.UserResource
import org.keycloak.representations.account.UserRepresentation
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.web.reactive.server.WebTestClient

@SpringBootTest
@AutoConfigureWebTestClient
class SignupTest(
    private val webTestClient: WebTestClient
) : BehaviorSpec({

    beforeEach {
        clearAllMocks()

    }

    fun request(request: SignupRequest) = webTestClient.post()
        .uri("/account/signup")
        .contentType(MediaType.APPLICATION_JSON)
        .bodyValue(request)

    Given("회원가입 실패한 경우") {
        When("RequestBody 유효성 검사 실패") {
            val request = signupRequest {
                name = ""
                email = ""
                password = ""
                passwordCheck = ""
            }
            val response = request(request).exchange()

            Then("status: 400 Bad Request") {
                response.expectStatus().isBadRequest
            }
            Then("body: fields 내에 존재하는 error 변수값은 존재한다") {
                response.expectBody(ErrorResponse::class.java).returnResult().responseBody!!.fields.forAll { error ->
                    error.field shouldNotBe null
                    error.message shouldNotBe null
                }
            }
        }

        When("'비밀번호'와 '비밀번호 확인' 서로 다른 경우") {
            val request = signupRequest {
                password = "1"
                passwordCheck = "2"
            }
            val response = request(request).exchange()

            Then("status: 400 Bad Request") {
                response.expectStatus().isBadRequest
            }
            Then("code: different_password, message: 비밀번호가 일치하지 않습니다") {
                response.expectBody(ErrorResponse::class.java).returnResult().responseBody!!.should {
                    it.code shouldBe AccountError.DIFFERENT_PASSWORD.code
                    it.message shouldBe AccountError.DIFFERENT_PASSWORD.message
                }
            }

        }

        When("계정이 이미 존재하는 경우") {
            val keycloakClient: KeycloakClient = mockk()
            val userResource: UserResource = mockk()
            every { keycloakClient.getByEmail(any())} returns userResource
            val request = signupRequest()
            val response = request(request).exchange()

            Then("status: 409 Conflict") {
                response.expectStatus().is4xxClientError
            }
        }
    }


    Given("회원가입 API 가입 성공") {
        When("계정이 만들어졌을 경우") {
            val keycloakClient: KeycloakClient = mockk()
            every { keycloakClient.getByEmail(any()) } returns null
            every { keycloakClient.registerBy(any()) } just Runs
            val request = signupRequest()
            val response = request(request).exchange()

            Then("status: 201 Created") {
                response.expectStatus().isCreated
            }
        }
    }
})