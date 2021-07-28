//
//  SignInViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 28/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
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
