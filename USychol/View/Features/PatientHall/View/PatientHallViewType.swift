//
//  PatientHallViewType.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 29/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol PatientHallViewType: AnyObject {
    var content: UIView { get }
    var delegate: PatientHallViewDelegate? { get set }
    func updateView(with viewState: PatientHallViewState)
}

public protocol PatientHallViewDelegate: AnyObject {
    func onHandleAddReminder()
    func onHandlePatientProfileRedirect()
}

extension PatientHallViewType where Self: UIView {
    public var content: UIView { return self }
}
