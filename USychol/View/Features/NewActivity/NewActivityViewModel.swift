//
//  NewActivityViewModel.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class NewActivityViewModel: NewActivityViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: NewActivityViewControllerType?
    public var viewEntity: NewActivityViewEntity?
    public var viewState: NewActivityViewState = .isEmpty {
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
