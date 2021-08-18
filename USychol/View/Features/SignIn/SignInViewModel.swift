//
//  SignInViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 28/07/21.
//

public class SignInViewModel: SignInViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: SignInViewControllerType?
    public var viewEntity: SignInViewEntity?
    public var viewState: SignInViewState = .isEmpty {
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

extension SignInViewModel: SignInViewControllerDelegate {
    public func getCurrentUserInfo() -> EntityTree {
        let userRepository = UserRepository()
        let userInfo = userRepository.getUser()!
        
        return userInfo
    }
    
    public func onHandleSignIn(email: String, password: String) -> EnumAuthResponse {
        let userRepository = UserRepository()
        let auth = userRepository.signIn(email: email, password: password)
        
        return auth
    }
}
