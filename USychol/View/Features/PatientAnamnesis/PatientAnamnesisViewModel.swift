//
//  PatientAnamnesisViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class PatientAnamnesisViewModel: PatientAnamnesisViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: PatientAnamnesisViewControllerType?
    public var viewEntity: PatientAnamnesisViewEntity?
    public var viewState: PatientAnamnesisViewState = .isEmpty {
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
