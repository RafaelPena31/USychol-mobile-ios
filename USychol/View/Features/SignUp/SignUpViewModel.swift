//
//  SignUpViewModel.swift
//  USychol
//
//  Created Fernando Rodrigues on 30/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class SignUpViewModel: SignUpViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: SignUpViewControllerType?
    public var viewEntity: SignUpViewEntity?
    public var viewState: SignUpViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }
    
    // MARK: - INITIALIZERS

    public init() {

    }
    
    // MARK: - PUBLIC API

    public func initState() {
        
    }
}

extension SignUpViewModel: SignUpViewControllerDelegate {
    public func onHandleSignUp(user: User, onAuthStateChange: @escaping (EnumAuthResponse) -> Void) {
        let userRepository = UserRepository()
        userRepository.signUp(user: user, completionRequest: onAuthStateChange)
    }
}
