//
//  VirtualPlanViewModel.swift
//  USychol
//
//  Created Fernando Rodrigues on 06/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class VirtualPlanViewModel: VirtualPlanViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: VirtualPlanViewControllerType?
    public var viewEntity: VirtualPlanViewEntity?
    public var viewState: VirtualPlanViewState = .isEmpty {
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

extension VirtualPlanViewModel: VirtualPlanViewControllerDelegate {
    
}
