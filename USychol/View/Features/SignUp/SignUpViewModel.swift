//
//  SignUpViewModel.swift
//  USychol
//
//  Created Fernando Rodrigues on 30/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import RxSwift

public class SignUpViewModel: SignUpViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: SignUpViewControllerType?
    public var viewEntity: SignUpViewEntity?
    public var viewState: SignUpViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }
    
    private var viewSignUpSubject: PublishSubject<EnumAuthResponse> = PublishSubject<EnumAuthResponse>()
    public lazy var viewSignUpObservable: Observable<EnumAuthResponse> = {
        return viewSignUpSubject.asObserver()
    }()
    
    // MARK: - INITIALIZERS

    public init() {

    }
    
    // MARK: - PUBLIC API

    public func initState() {
        
    }
    
    public func onHandleSignUp(user: User) {
        let userRepository = UserRepository()
        userRepository.signUp(user: user) { [weak self] in
            self?.viewSignUpSubject.onNext($0)
        }
    }
}

extension SignUpViewModel: SignUpViewControllerDelegate {

}
