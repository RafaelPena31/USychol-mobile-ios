//
//  SignInProtocols.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 28/07/21.
//

import RxSwift

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
    
    var viewSignInObservable: Observable<EnumAuthResponse> { get }
    
    func initState()
    func onHandleSignIn(email: String, password: String) -> Void
}

public protocol SignInViewControllerDelegate: AnyObject {
    func getCurrentUserInfo() -> EntityTree
}
