import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("org.springframework.boot") version "2.7.5"
    id("io.spring.dependency-management") version "1.0.15.RELEASE"
    kotlin("jvm") version "1.6.21"
    kotlin("plugin.spring") version "1.6.21"
}

group = "com.jys"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_11

configurations {
    compileOnly {
        extendsFrom(configurations.annotationProcessor.get())
    }
}

repositories {
    mavenCentral()
}

dependencies {
    // Bill of Materials (BOM)
    implementation(platform("io.kotest:kotest-bom:5.4.2"))
    implementation(platform("org.testcontainers:testcontainers-bom:1.17.3"))
    implementation(platform("org.springframework.cloud:spring-cloud-dependencies:2021.0.4"))

    implementation("org.springframework.boot:spring-boot-starter-thymeleaf")
    implementation("org.springframework.boot:spring-boot-starter-webflux")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-reactive")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-reactor")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("io.projectreactor.kotlin:reactor-kotlin-extensions")
    implementation("org.springframework.boot:spring-boot-starter-validation")
    implementation("org.springframework.boot:spring-boot-starter-security")
    implementation("org.keycloak:keycloak-spring-boot-starter:20.0.1")
    implementation("org.keycloak.bom:keycloak-adapter-bom:20.0.1")
    implementation("org.keycloak:keycloak-admin-client:20.0.1")

    testImplementation ("org.springframework.boot:spring-boot-starter-test")
    testImplementation ("org.testcontainers:testcontainers:1.16.3")
    testImplementation ("org.testcontainers:junit-jupiter:1.17.2")
    testImplementation ("org.testcontainers:mongodb:1.17.2")

    testImplementation ("com.ninja-squad:springmockk:3.1.1")
    testImplementation ("io.kotest.extensions:kotest-extensions-spring:1.1.2")
    testImplementation ("io.kotest.extensions:kotest-extensions-testcontainers:1.3.4")
    testImplementation ("io.kotest:kotest-assertions-core")
    testImplementation ("io.kotest:kotest-framework-datatest")
    testImplementation ("io.kotest:kotest-runner-junit5")
    testImplementation ("io.mockk:mockk:1.13.1")
    testImplementation ("io.projectreactor:reactor-test")
    testImplementation ("org.springframework.cloud:spring-cloud-starter-contract-stub-runner")
    testImplementation ("org.testcontainers:mongodb")
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs = listOf("-Xjsr305=strict")
        jvmTarget = "11"
    }
}

tasks.withType<Test> {
    useJUnitPlatform()
}
