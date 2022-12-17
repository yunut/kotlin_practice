package com.jys.kotlin_practice.config

import org.springframework.security.oauth2.server.resource.authentication.BearerTokenAuthentication

/**
 * 토큰에서 sub 헤더 추출
 */
val BearerTokenAuthentication.subject: String?
    get() = this.tokenAttributes["sub"]?.toString()
