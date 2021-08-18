//
//  AuthEntityTree.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 17/08/21.
//

public struct EntityTree: Codable {
    let userInfo: User
    let patient: [Patient]
    let reminder: [Reminder]
}

public struct AuthEntityTree: Codable {
    let userID: String
    let entity: EntityTree
}
