//
//  SignUpProtocols.swift
//  USychol
//
//  Created Fernando Rodrigues on 30/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol SignUpViewControllerType: AnyObject {
    var contentView: SignUpViewType? { get }
    var viewModel: SignUpViewModelType? { get }
    var delegate: SignUpViewControllerDelegate? { get set }
    func updateView(with viewState: SignUpViewState)
}

public protocol SignUpViewModelType: AnyObject {
    var viewController: SignUpViewControllerType? { get }
    var viewEntity: SignUpViewEntity? { get set }
    var viewState: SignUpViewState { get }
    
    func initState()
}

public protocol SignUpViewControllerDelegate: AnyObject {
    func signUp(psycho: Psycho)
}
