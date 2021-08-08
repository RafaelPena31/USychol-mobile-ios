
//
//  NewReportViewController.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class NewReportViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: NewReportViewModelType?
    public let contentView: NewReportViewType?

    // MARK: - PUBLIC API

    public weak var delegate: NewReportViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: NewReportViewType = NewReportView(),
                viewModel: NewReportViewModelType) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LIFE CYCLE

    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.initState()
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        contentSetup()
    }
    
    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
}

extension NewReportViewController: NewReportViewControllerType {
    public func updateView(with viewState: NewReportViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension NewReportViewController: NewReportViewDelegate {

}
