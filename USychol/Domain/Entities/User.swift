//
//  User.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 12/08/21.
//

public enum Plans: String, Codable {
    case virtual
    case digital
    case full
}

public struct User: Equatable, Codable {
    let id: String
    
    let name: String
    let email: String
    let age: String
    let crp: String
    let cpf: String
    let plan: Plans?
    let password: String
}
