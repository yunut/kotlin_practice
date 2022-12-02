package com.jys.kotlin_practice.keycloak

import com.jys.kotlin_practice.account.SignupRequest
import org.keycloak.admin.client.KeycloakBuilder
import org.keycloak.admin.client.resource.RealmResource
import org.springframework.http.HttpStatus
import org.springframework.web.server.ResponseStatusException

class KeycloakClient(
    keycloakProperties: KeycloakProperties
) {
    private val realmResource: RealmResource =
        KeycloakBuilder.builder()
            .realm(keycloakProperties.realm)
            .grantType(keycloakProperties.grantType)
            .serverUrl(keycloakProperties.authServerUrl)
            .clientId(keycloakProperties.clientId)
            .clientSecret(keycloakProperties.clientSecret)
            .build().realm(keycloakProperties.realm)

    /**
     * keycloak 회원 생성
     * @param request 회원 가입 요청 데이터
     */
    fun registerBy(request: SignupRequest) {
        val response = realmResource.users().create(createUserBy(request))
        if (response.status != 201) throw ResponseStatusException(HttpStatus.valueOf(response.status))
        addRestClientRole(getByEmail(request.email).id)
    }

    /**
     * 이메일로 keycloak 유저 Search
     *
     * @param email 이메일
     */
    fun searchByEmail(email: String) =
        realmResource.users().search(email, true)

    /**
     * 이메일로 keycloak 유저 Get
     *
     * @param email 이메일
     */
    fun getByEmail(email: String) =
        realmResource.users().get(email).toRepresentation() ?: throw ResponseStatusException(HttpStatus.NOT_FOUND)

    /**
     * rest-client 권한 부여
     *
     * @param id 회원 번호
     */
    private fun addRestClientRole(id: String) {
        val role = getRoleByName(KeycloakRoles.REST_CLIENT)
        realmResource.users().get(id).roles().realmLevel().add(listOf(role))
    }

    /**
     * 권한 조회
     *
     * @param role 권한 명
     */
    private fun getRoleByName(role: String) = realmResource.roles()
        .get(role).toRepresentation()


}