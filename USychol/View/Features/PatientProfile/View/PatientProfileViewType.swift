//
//  PatientProfileViewType.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol PatientProfileViewType: AnyObject {
    var content: UIView { get }
    var delegate: PatientProfileViewDelegate? { get set }
    func updateView(with viewState: PatientProfileViewState)
}

public protocol PatientProfileViewDelegate: AnyObject {
    func onHandleSearchReport()
    func onHandleAccessAnamnesis()
    func onHandleCreateActivy()
    func onHandleCreateReport()
    func onHandleAccessReport()
}

extension PatientProfileViewType where Self: UIView {
    public var content: UIView { return self }
}
