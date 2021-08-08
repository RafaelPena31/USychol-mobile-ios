//
//  VirtualPlanViewType.swift
//  USychol
//
//  Created Fernando Rodrigues on 06/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol VirtualPlanViewType: AnyObject {
    var content: UIView { get }
    var delegate: VirtualPlanViewDelegate? { get set }
    func updateView(with viewState: VirtualPlanViewState)
}

public protocol VirtualPlanViewDelegate: AnyObject {
    func onHandleClick()
    func onHandleTouch()
}

extension VirtualPlanViewType where Self: UIView {
    public var content: UIView { return self }
}
