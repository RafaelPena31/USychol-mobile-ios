//
//  Psycho.swift
//  USychol
//
//  Created by Fernando Rodrigues on 14/08/21.
//

public enum Plans {
    case virtual
    case digital
    case full
}

public struct Psycho: Equatable {
    let name: String
    let email: String
    let registration: String
    let birthday: String
    let idDocument: String
    let password: String
    let plans: Plans?
}
