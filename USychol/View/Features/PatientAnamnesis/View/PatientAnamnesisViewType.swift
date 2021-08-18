//
//  PatientAnamnesisViewType.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol PatientAnamnesisViewType: AnyObject {
    var content: UIView { get }
    var delegate: PatientAnamnesisViewDelegate? { get set }
    func updateView(with viewState: PatientAnamnesisViewState)
}

public protocol PatientAnamnesisViewDelegate: AnyObject {
    func onHandleUpdatePatient(patient: Patient)
    func handleFormAlert()
}

extension PatientAnamnesisViewType where Self: UIView {
    public var content: UIView { return self }
}
