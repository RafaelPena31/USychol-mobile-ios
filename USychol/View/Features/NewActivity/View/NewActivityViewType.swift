//
//  NewActivityViewType.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol NewActivityViewType: AnyObject {
    var content: UIView { get }
    var delegate: NewActivityViewDelegate? { get set }
    func updateView(with viewState: NewActivityViewState)
}

public protocol NewActivityViewDelegate: AnyObject {
    // events clicks on view
}

extension NewActivityViewType where Self: UIView {
    public var content: UIView { return self }
}
