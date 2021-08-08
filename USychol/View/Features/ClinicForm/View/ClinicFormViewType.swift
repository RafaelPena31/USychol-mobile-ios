//
//  ClinicFormViewType.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 07/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol ClinicFormViewType: AnyObject {
    var content: UIView { get }
    var delegate: ClinicFormViewDelegate? { get set }
    func updateView(with viewState: ClinicFormViewState)
}

public protocol ClinicFormViewDelegate: AnyObject {
    func onHandleEditInfo()
}

extension ClinicFormViewType where Self: UIView {
    public var content: UIView { return self }
}
