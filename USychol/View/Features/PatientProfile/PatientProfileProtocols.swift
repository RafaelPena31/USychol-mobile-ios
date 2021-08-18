//
//  PatientProfileProtocols.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol PatientProfileViewControllerType: AnyObject {
    var contentView: PatientProfileViewType? { get }
    var viewModel: PatientProfileViewModelType? { get }
    var delegate: PatientProfileViewControllerDelegate? { get set }
    func updateView(with viewState: PatientProfileViewState)
}

public protocol PatientProfileViewModelType: AnyObject {
    var viewController: PatientProfileViewControllerType? { get }
    var viewEntity: PatientProfileViewEntity? { get set }
    var viewState: PatientProfileViewState { get }
    
    func initState()
    func updateState()
}

public protocol PatientProfileViewControllerDelegate: AnyObject {
    func setCurrentReport(report: Report) -> Bool
}

public protocol PatientProfileViewControllerViewDelegate: AnyObject {
    func reloadData()
}

public protocol PatientProfileBackStateChangeControl: AnyObject {
    func handleStateChange()
}
