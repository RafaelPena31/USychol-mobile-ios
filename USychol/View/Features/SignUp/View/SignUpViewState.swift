//
//  SignUpViewState.swift
//  USychol
//
//  Created Fernando Rodrigues on 30/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public enum SignUpViewState: Equatable {
    case hasData(SignUpViewEntity)
    case isEmpty
    case hasSignUp(Bool)
}
