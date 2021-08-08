//
//  PatientReportViewType.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol PatientReportViewType: AnyObject {
    var content: UIView { get }
    var delegate: PatientReportViewDelegate? { get set }
    func updateView(with viewState: PatientReportViewState)
}

public protocol PatientReportViewDelegate: AnyObject {
    func onHandleEditReport()
}

extension PatientReportViewType where Self: UIView {
    public var content: UIView { return self }
}
