//
//  SignUpViewType.swift
//  USychol
//
//  Created Fernando Rodrigues on 30/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol SignUpViewType: AnyObject {
    var content: UIView { get }
    var delegate: SignUpViewDelegate? { get set }
    func updateView(with viewState: SignUpViewState)
}

public protocol SignUpViewDelegate: AnyObject {
    func onHandleClick()
    func onHandleChange()
}

extension SignUpViewType where Self: UIView {
    public var content: UIView { return self }
}
