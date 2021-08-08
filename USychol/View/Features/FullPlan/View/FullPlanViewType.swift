//
//  FullPlanViewType.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol FullPlanViewType: AnyObject {
    var content: UIView { get }
    var delegate: FullPlanViewDelegate? { get set }
    func updateView(with viewState: FullPlanViewState)
}

public protocol FullPlanViewDelegate: AnyObject {
    func onHandleClick()
    func onHandleTouch()
}

extension FullPlanViewType where Self: UIView {
    public var content: UIView { return self }
}
