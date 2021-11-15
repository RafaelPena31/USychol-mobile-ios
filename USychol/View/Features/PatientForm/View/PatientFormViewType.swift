//
//  PatientFormViewType.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 06/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol PatientFormViewType: AnyObject {
    var content: UIView { get }
    var delegate: PatientFormViewDelegate? { get set }
    func updateView(with viewState: PatientFormViewState)
}

public protocol PatientFormViewDelegate: AnyObject {
    func onHandleCreatePatient(patient: PatientFB)
}

extension PatientFormViewType where Self: UIView {
    public var content: UIView { return self }
}
