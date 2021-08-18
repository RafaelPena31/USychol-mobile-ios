//
//  PatientFormProtocols.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 06/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol PatientFormViewControllerType: AnyObject {
    var contentView: PatientFormViewType? { get }
    var viewModel: PatientFormViewModelType? { get }
    var delegate: PatientFormViewControllerDelegate? { get set }
    func updateView(with viewState: PatientFormViewState)
}

public protocol PatientFormViewModelType: AnyObject {
    var viewController: PatientFormViewControllerType? { get }
    var viewEntity: PatientFormViewEntity? { get set }
    var viewState: PatientFormViewState { get }
    
    func initState()
}

public protocol PatientFormViewControllerDelegate: AnyObject {
    func onHandleCreatePatient(patient: Patient) -> Bool
}

public protocol PatientFormBackStateChangeControl: AnyObject {
    func handleStateChange()
}
