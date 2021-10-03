//
//  DigitalPlanProtocols.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol DigitalPlanViewControllerType: AnyObject {
    var contentView: DigitalPlanViewType? { get }
    var viewModel: DigitalPlanViewModelType? { get }
    var delegate: DigitalPlanViewControllerDelegate? { get set }
    func updateView(with viewState: DigitalPlanViewState)
}

public protocol DigitalPlanViewModelType: AnyObject {
    var viewController: DigitalPlanViewControllerType? { get }
    var viewEntity: DigitalPlanViewEntity? { get set }
    var viewState: DigitalPlanViewState { get }
    
    func initState()
}

public protocol DigitalPlanViewControllerDelegate: AnyObject {
    func setPlan(_ onHandleSetPlan:@escaping (_ updateStatus: Bool) -> Void) -> Void
}
