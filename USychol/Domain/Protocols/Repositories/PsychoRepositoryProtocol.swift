//
//  PsychoRepositoryProtocol.swift
//  USychol
//
//  Created by Fernando Rodrigues on 14/08/21.
//

public protocol PsychoRepositoryProtocol {
    func signIn(email: String, password: String) -> Bool
    func signUp(psycho: Psycho) -> Void
}

