//
//  NewActivityProtocols.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol NewActivityViewControllerType: AnyObject {
    var contentView: NewActivityViewType? { get }
    var viewModel: NewActivityViewModelType? { get }
    var delegate: NewActivityViewControllerDelegate? { get set }
    func updateView(with viewState: NewActivityViewState)
}

public protocol NewActivityViewModelType: AnyObject {
    var viewController: NewActivityViewControllerType? { get }
    var viewEntity: NewActivityViewEntity? { get set }
    var viewState: NewActivityViewState { get }
    
    func initState()
}

public protocol NewActivityViewControllerDelegate: AnyObject {
    func onHandleCreateActivy(_ activy: PerformActivy)
}
