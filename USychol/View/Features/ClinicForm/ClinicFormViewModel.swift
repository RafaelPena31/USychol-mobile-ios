//
//  ClinicFormViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 07/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class ClinicFormViewModel: ClinicFormViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: ClinicFormViewControllerType?
    public var viewEntity: ClinicFormViewEntity?
    public var viewState: ClinicFormViewState = .isEmpty {
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
