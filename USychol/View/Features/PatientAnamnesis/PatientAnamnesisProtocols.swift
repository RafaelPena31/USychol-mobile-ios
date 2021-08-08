//
//  PatientAnamnesisProtocols.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol PatientAnamnesisViewControllerType: AnyObject {
    var contentView: PatientAnamnesisViewType? { get }
    var viewModel: PatientAnamnesisViewModelType? { get }
    var delegate: PatientAnamnesisViewControllerDelegate? { get set }
    func updateView(with viewState: PatientAnamnesisViewState)
}

public protocol PatientAnamnesisViewModelType: AnyObject {
    var viewController: PatientAnamnesisViewControllerType? { get }
    var viewEntity: PatientAnamnesisViewEntity? { get set }
    var viewState: PatientAnamnesisViewState { get }
    
    func initState()
}

public protocol PatientAnamnesisViewControllerDelegate: AnyObject {
    
}
