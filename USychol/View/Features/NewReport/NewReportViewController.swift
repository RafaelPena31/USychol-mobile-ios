
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
        headerSetup()
    }
    
    private func headerSetup() {
            let rightButton = UIButton()
            
            rightButton.addTarget(self, action: #selector(onRightHeaderButtonClick), for: .touchUpInside)
            
            _ = CoreHeader(type: .main, isRightButtonAvailable: true, navigationItem: self.navigationItem, navigationController: self.navigationController!, rightButton: rightButton)
        }
    
    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
    
    // MARK: - ACTIONS
    
    @objc func onRightHeaderButtonClick() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewReportViewController: NewReportViewControllerType {
    public func updateView(with viewState: NewReportViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension NewReportViewController: NewReportViewDelegate {
    public func handleErrorAlert() {
        let alert = CoreAlerts().handleErrorAlert(title: "Warning", message: "Please fill in all fields with valid data", buttonText: "Go Fill")
        self.present(alert, animated: true)
    }
    
    public func onHandleCreateReport(_ report: Report) {
        delegate?.onHandleCreateReport(report)
    }
}
