//
//  FullPlanProtocols.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol FullPlanViewControllerType: AnyObject {
    var contentView: FullPlanViewType? { get }
    var viewModel: FullPlanViewModelType? { get }
    var delegate: FullPlanViewControllerDelegate? { get set }
    func updateView(with viewState: FullPlanViewState)
}

public protocol FullPlanViewModelType: AnyObject {
    var viewController: FullPlanViewControllerType? { get }
    var viewEntity: FullPlanViewEntity? { get set }
    var viewState: FullPlanViewState { get }
    
    func initState()
}

public protocol FullPlanViewControllerDelegate: AnyObject {
    
}
