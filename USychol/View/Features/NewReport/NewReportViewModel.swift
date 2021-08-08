//
//  NewReportViewModel.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class NewReportViewModel: NewReportViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: NewReportViewControllerType?
    public var viewEntity: NewReportViewEntity?
    public var viewState: NewReportViewState = .isEmpty {
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
