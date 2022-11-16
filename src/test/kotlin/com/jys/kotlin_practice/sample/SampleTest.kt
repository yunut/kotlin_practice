package com.jys.kotlin_practice.sample

import io.kotest.core.spec.style.BehaviorSpec
import io.kotest.matchers.ints.shouldBeGreaterThan
import io.mockk.clearAllMocks

/**
 * Behavior 기반 테스트 코드
 */
class SampleTest : BehaviorSpec({

    beforeEach {
        clearAllMocks()
    }

    val scores = List(5) {
        it.times(2)
    }

    Given("점수 리스트 테스트") {
        When("점수 리스트 내에 3의 약수가 존재하는 경우") {
            val number = 3

            Then("3의 약수의 개수는 1개 이상이다") {
                scores.count { it.mod(number) == 0 } shouldBeGreaterThan 0
            }
        }
    }

})