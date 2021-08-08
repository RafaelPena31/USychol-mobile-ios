//
//  DigitalPlanViewModel.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class DigitalPlanViewModel: DigitalPlanViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: DigitalPlanViewControllerType?
    public var viewEntity: DigitalPlanViewEntity?
    public var viewState: DigitalPlanViewState = .isEmpty {
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
