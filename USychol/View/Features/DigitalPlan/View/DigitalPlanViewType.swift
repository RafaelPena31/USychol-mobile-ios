//
//  DigitalPlanViewType.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol DigitalPlanViewType: AnyObject {
    var content: UIView { get }
    var delegate: DigitalPlanViewDelegate? { get set }
    func updateView(with viewState: DigitalPlanViewState)
}

public protocol DigitalPlanViewDelegate: AnyObject {
    func onHandleClick()
    func onHandleTouch()
}

extension DigitalPlanViewType where Self: UIView {
    public var content: UIView { return self }
}
