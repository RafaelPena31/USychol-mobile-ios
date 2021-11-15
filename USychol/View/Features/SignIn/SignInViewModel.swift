//
//  SignInViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 28/07/21.
//

import RxSwift

public class SignInViewModel: SignInViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: SignInViewControllerType?
    public var viewEntity: SignInViewEntity?
    public var viewState: SignInViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }
    
    private var viewSignInSubject: PublishSubject<EnumAuthResponse> = PublishSubject<EnumAuthResponse>()
    public lazy var viewSignInObservable: Observable<EnumAuthResponse> = {
        return viewSignInSubject.asObservable()
    }()

    
    // MARK: - INITIALIZERS

    public init() {
        
    }
    
    // MARK: - PUBLIC API

    public func initState() {
        
    }
    
    public func onHandleSignIn(email: String, password: String) {
        let userRepository = UserRepository()
        userRepository.signIn(email: email, password: password) { [weak self] in
            self?.viewSignInSubject.onNext($0)
        }
    }
}

extension SignInViewModel: SignInViewControllerDelegate {
    public func getCurrentUserInfo() -> EntityTree {
        let userRepository = UserRepository()
        let userInfo = userRepository.getUser()!
        
        return userInfo
    }
}
