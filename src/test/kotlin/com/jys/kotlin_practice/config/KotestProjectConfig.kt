package com.jys.kotlin_practice.config

import io.kotest.core.config.AbstractProjectConfig

/**
 * Kotest 프로젝트 설정
 *
 * 참고: [Project Level Config](https://kotest.io/docs/framework/project-config.html)
 */
object KotestProjectConfig : AbstractProjectConfig() {
    // Coroutine debug 모드 활성화
    override val coroutineDebugProbes: Boolean = true

    // Test 이름에서 불필요한 whitespace 제거
    override val testNameRemoveWhitespace: Boolean = true
}
