//
//  SignInProtocols.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 28/07/21.
//

public protocol SignInViewControllerType: AnyObject {
    var contentView: SignInViewType? { get }
    var viewModel: SignInViewModelType? { get }
    var delegate: SignInViewControllerDelegate? { get set }
    func updateView(with viewState: SignInViewState)
}

public protocol SignInViewModelType: AnyObject {
    var viewController: SignInViewControllerType? { get }
    var viewEntity: SignInViewEntity? { get set }
    var viewState: SignInViewState { get }
    
    func initState()
}

public protocol SignInViewControllerDelegate: AnyObject {
    func onHandleSignIn(email: String, password: String) -> EnumAuthResponse
    func getCurrentUserInfo() -> EntityTree
}
