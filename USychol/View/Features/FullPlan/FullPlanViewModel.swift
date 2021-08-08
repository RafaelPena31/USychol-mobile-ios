//
//  FullPlanViewModel.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class FullPlanViewModel: FullPlanViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: FullPlanViewControllerType?
    public var viewEntity: FullPlanViewEntity?
    public var viewState: FullPlanViewState = .isEmpty {
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
