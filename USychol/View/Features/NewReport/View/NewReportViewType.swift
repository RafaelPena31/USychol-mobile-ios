//
//  NewReportViewType.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
import UIKit

public protocol NewReportViewType: AnyObject {
    var content: UIView { get }
    var delegate: NewReportViewDelegate? { get set }
    func updateView(with viewState: NewReportViewState)
}

public protocol NewReportViewDelegate: AnyObject {
    // events clicks on view
}

extension NewReportViewType where Self: UIView {
    public var content: UIView { return self }
}
