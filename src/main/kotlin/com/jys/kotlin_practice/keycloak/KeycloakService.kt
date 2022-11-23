package com.jys.kotlin_practice.keycloak

import com.jys.kotlin_practice.account.SignupRequest
import org.keycloak.admin.client.resource.RealmResource
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException

@Service
class KeycloakService(
    private val keycloakClient: RealmResource
) {
    /**
     * keycloak 회원 생성
     * @param request SignupRequest
     */
    fun registerBy(request: SignupRequest) {
        val response = keycloakClient.users().create(createUserBy(request))
        if (response.status != 201) throw ResponseStatusException(HttpStatus.valueOf(response.status))
        getByEmail(request.email).let {
            addRestClientRole(it.id)
        }
    }

    /**
     * 이메일로 keycloak 유저 조회
     *
     * @param email 이메일
     */
    fun getByEmail(email: String) =
        keycloakClient.users().search(email, true).firstOrNull() ?: throw ResponseStatusException(HttpStatus.NOT_FOUND)

    /**
     * rest-client 권한 부여
     *
     * @param id 회원 번호
     */
    private fun addRestClientRole(id: String) {
        val role = getRoleByName(KeyCloakRoles.REST_CLIENT)
        keycloakClient.users().get(id).roles().realmLevel().add(listOf(role))
    }

    /**
     * 권한 조회
     *
     * @param role 권한 명
     */
    private fun getRoleByName(role: String) = keycloakClient.roles()
        .get(role).toRepresentation()
}