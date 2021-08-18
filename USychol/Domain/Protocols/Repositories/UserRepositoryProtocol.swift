//
//  UserRepositoryProtocol.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 13/08/21.
//

public enum EnumAuthResponse {
    case authenticated
    case unauthenticated
    case error(String)
}

public protocol UserRepositoryProtocol {
    func getUser() -> EntityTree?
    func signIn(email: String, password: String) -> EnumAuthResponse
    func signUp(name: String, email: String, age: String, crp: String, cpf: String, password: String) -> EnumAuthResponse
    func updateData(userInfo: EntityTree) -> Bool
}
