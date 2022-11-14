package com.jys.kotlin_practice.account

import com.jys.kotlin_practice.account.document.Account
import com.jys.kotlin_practice.account.repository.AccountRepository
import org.assertj.core.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.data.mongo.DataMongoTest
import org.springframework.test.context.junit.jupiter.SpringExtension
import reactor.test.StepVerifier

/**
 * 해당 클래스는 mongodb 초기 설정을 테스트 하는 용도로 추후에 제거
 */
@ExtendWith(SpringExtension::class)
@DataMongoTest
class AccountRepositoryTest (
        @Autowired
        private val accountRepository: AccountRepository
        ) {

    @Test
    fun `회원 데이터를 저장한다`() {
        val name = "테스트"
        val email = "test@test.com"
        val pw = "1234"

        val account = Account(
                name = name,
                email = email,
                pw = pw,
                address = null
        )

        accountRepository.save(account)
                .`as` { StepVerifier.create(it) }
                .assertNext{
                    Assertions.assertThat(it.id).isNotNull()
                    Assertions.assertThat(it.name).isEqualTo(name)
                    Assertions.assertThat(it.pw).isEqualTo(pw)
                }
                .verifyComplete()
    }

}