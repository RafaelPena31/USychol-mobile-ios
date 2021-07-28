//
//  SignInProtocols.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 28/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
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
    
}
