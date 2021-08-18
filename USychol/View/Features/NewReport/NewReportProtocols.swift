//
//  NewReportProtocols.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol NewReportViewControllerType: AnyObject {
    var contentView: NewReportViewType? { get }
    var viewModel: NewReportViewModelType? { get }
    var delegate: NewReportViewControllerDelegate? { get set }
    func updateView(with viewState: NewReportViewState)
}

public protocol NewReportViewModelType: AnyObject {
    var viewController: NewReportViewControllerType? { get }
    var viewEntity: NewReportViewEntity? { get set }
    var viewState: NewReportViewState { get }
    
    func initState()
}

public protocol NewReportViewControllerDelegate: AnyObject {
    func onHandleCreateReport(_ report: Report) -> Bool
}

public protocol NewReportBackStateChangeControl: AnyObject {
    func NewReportHandleStateChange()
}
