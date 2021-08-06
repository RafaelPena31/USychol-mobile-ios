//
//  SignInViewType.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 28/07/21.
//
import UIKit

public protocol SignInViewType: AnyObject {
    var content: UIView { get }
    var delegate: SignInViewDelegate? { get set }
    func updateView(with viewState: SignInViewState)
}

public protocol SignInViewDelegate: AnyObject {
    func onHandleClick()
}

extension SignInViewType where Self: UIView {
    public var content: UIView { return self }
}
