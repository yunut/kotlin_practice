package com.jys.kotlin_practice.account

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping

@Controller
@RequestMapping(value = ["/account"])
class AccountViewController {

    /**
     * 로그인 페이지
     */
    @GetMapping(value = ["/signin"])
    fun signin() = "/signin"

    /**
     * 회원가입 페이지
     */
    @GetMapping(value = ["/signup"])
    fun signup() = "/signup"

    /**
     * 메인 페이지
     */
    @GetMapping(value = ["/main"])
    fun main() = "/main"

}