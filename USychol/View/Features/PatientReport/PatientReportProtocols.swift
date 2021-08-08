//
//  PatientReportProtocols.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol PatientReportViewControllerType: AnyObject {
    var contentView: PatientReportViewType? { get }
    var viewModel: PatientReportViewModelType? { get }
    var delegate: PatientReportViewControllerDelegate? { get set }
    func updateView(with viewState: PatientReportViewState)
}

public protocol PatientReportViewModelType: AnyObject {
    var viewController: PatientReportViewControllerType? { get }
    var viewEntity: PatientReportViewEntity? { get set }
    var viewState: PatientReportViewState { get }
    
    func initState()
}

public protocol PatientReportViewControllerDelegate: AnyObject {
    
}
