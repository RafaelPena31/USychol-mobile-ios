//
//  PatientFormViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 06/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class PatientFormViewModel: PatientFormViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: PatientFormViewControllerType?
    public var viewEntity: PatientFormViewEntity?
    public var viewState: PatientFormViewState = .isEmpty {
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