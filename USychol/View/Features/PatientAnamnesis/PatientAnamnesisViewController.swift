
//
//  PatientAnamnesisViewController.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class PatientAnamnesisViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: PatientAnamnesisViewModelType?
    public let contentView: PatientAnamnesisViewType?

    // MARK: - PUBLIC API

    public weak var delegate: PatientAnamnesisViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: PatientAnamnesisViewType = PatientAnamnesisView(),
                viewModel: PatientAnamnesisViewModelType) {
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
        let subtitle = CoreLabel(type: .cardText, text: "Anamnesis", color: "StrongParcialWhiteColor")
        
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
    
    public func onHandleFormAlertError() {
        let alert = CoreAlerts().handleDefaultAlert(title: "USychol", message: "Unable to update your data, please contact the USychol Team support team", buttonText: "Continue")
        self.present(alert, animated: true)
    }
    
    // MARK: - ACTIONS
    
    @objc func onLeftHeaderButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PatientAnamnesisViewController: PatientAnamnesisViewControllerType {
    public func updateView(with viewState: PatientAnamnesisViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension PatientAnamnesisViewController: PatientAnamnesisViewDelegate {
    private func onHandleUpdated(_ state: Bool) {
        if state {
            onLeftHeaderButtonClick()
        } else {
            onHandleFormAlertError()
        }
    }
    
    public func onHandleUpdatePatient(patient: Patient) {
        delegate!.onHandleUpdatePatient(patient: patient, onHandleUpdated: onHandleUpdated)
    }
    
    public func handleFormAlert() {
        let alert = CoreAlerts().handleCreateFormAlert()
        self.present(alert, animated: true)
    }
}
