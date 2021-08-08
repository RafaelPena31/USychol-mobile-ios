
//
//  PatientReportViewController.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class PatientReportViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: PatientReportViewModelType?
    public let contentView: PatientReportViewType?

    // MARK: - PUBLIC API

    public weak var delegate: PatientReportViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: PatientReportViewType = PatientReportView(),
                viewModel: PatientReportViewModelType) {
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
        headerSetup()
        contentSetup()
    }
    
    private func headerSetup() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainPurpleColor")
        
        let title = CoreLabel(type: .title, text: "James Sirius", color: "WhiteColor")
        let subtitle = CoreLabel(type: .cardText, text: "Report", color: "StrongParcialWhiteColor")
        
        let stack = UIStackView(arrangedSubviews: [title, subtitle])
        
        stack.alignment = .center
        stack.axis = .vertical
        
        self.navigationItem.titleView = stack
        
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "arrow-left-icon"), for: .normal)
        leftButton.tintColor = .white
        
        leftButton.addTarget(self, action: #selector(onLeftHeaderButtonClick), for: .touchUpInside)
        
        let leftButtonNavBar = UIBarButtonItem(customView: leftButton)
        
        navigationItem.leftBarButtonItem = leftButtonNavBar
    }
    
    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
    
    // MARK: - ACTIONS
    
    @objc func onLeftHeaderButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PatientReportViewController: PatientReportViewControllerType {
    public func updateView(with viewState: PatientReportViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension PatientReportViewController: PatientReportViewDelegate {

}
