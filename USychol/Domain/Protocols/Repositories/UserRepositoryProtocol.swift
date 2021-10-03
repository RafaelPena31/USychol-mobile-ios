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
    func signIn(email: String, password: String, completionRequest:@escaping (_ state: EnumAuthResponse) -> Void) -> Void
    func signUp(user: User, completionRequest:@escaping (_ state: EnumAuthResponse) -> Void) -> Void
    func updateData(userInfo: EntityTree, completionRequest:@escaping (_ state: Bool) -> Void) -> Void
}
