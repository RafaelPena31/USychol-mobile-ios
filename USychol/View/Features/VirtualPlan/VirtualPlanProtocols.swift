//
//  VirtualPlanProtocols.swift
//  USychol
//
//  Created Fernando Rodrigues on 06/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol VirtualPlanViewControllerType: AnyObject {
    var contentView: VirtualPlanViewType? { get }
    var viewModel: VirtualPlanViewModelType? { get }
    var delegate: VirtualPlanViewControllerDelegate? { get set }
    func updateView(with viewState: VirtualPlanViewState)
}

public protocol VirtualPlanViewModelType: AnyObject {
    var viewController: VirtualPlanViewControllerType? { get }
    var viewEntity: VirtualPlanViewEntity? { get set }
    var viewState: VirtualPlanViewState { get }
    
    func initState()
}

public protocol VirtualPlanViewControllerDelegate: AnyObject {
    func setPlan() -> Bool
}
