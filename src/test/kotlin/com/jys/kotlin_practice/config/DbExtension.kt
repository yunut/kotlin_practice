package com.jys.kotlin_practice.config

import io.kotest.core.annotation.AutoScan
import io.kotest.core.listeners.AfterProjectListener
import io.kotest.core.listeners.BeforeProjectListener
import org.testcontainers.containers.MongoDBContainer

/**
 * Kotest Extension 기반 Test 전용 MongoDB Container 실행
 *
 * 참고: [Kotest > Extensions](https://kotest.io/docs/framework/extensions/extensions-introduction.html)
 */
//@AutoScan
object DbExtension : BeforeProjectListener, AfterProjectListener {
    private val mongo = MongoDBContainer("mongo:4.0")

    override suspend fun beforeProject() {
        mongo.start()
        System.setProperty("spring.data.mongodb.uri", mongo.replicaSetUrl)
    }
}
