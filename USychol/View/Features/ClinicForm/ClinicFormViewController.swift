
//
//  ClinicFormViewController.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 07/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class ClinicFormViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: ClinicFormViewModelType?
    public let contentView: ClinicFormViewType?

    // MARK: - PUBLIC API

    public weak var delegate: ClinicFormViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: ClinicFormViewType = ClinicFormView(),
                viewModel: ClinicFormViewModelType) {
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
        
        let title = CoreLabel(type: .title, text: "Clinic Profile", color: "WhiteColor")
        let subtitle = CoreLabel(type: .cardText, text: "USychol Plan: Complete Psychologist", color: "StrongParcialWhiteColor")
        
        let stack = UIStackView(arrangedSubviews: [title, subtitle])
        
        stack.alignment = .center
        stack.axis = .vertical
        
        self.navigationItem.titleView = stack
        
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "arrow-left-icon"), for: .normal)
        leftButton.tintColor = .white
        
        leftButton.addTarget(self, action: #selector(onLeftHeaderButtonClick), for: .touchUpInside)
        
        let leftButtonNavBar = UIBarButtonItem(customView: leftButton)
        
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "exit-icon"), for: .normal)
        rightButton.tintColor = .white
        
        rightButton.addTarget(self, action: #selector(onRightHeaderButtonClick), for: .touchUpInside)
        
        let rightButtonNavBar = UIBarButtonItem(customView: rightButton)
        
        navigationItem.leftBarButtonItem = leftButtonNavBar
        navigationItem.rightBarButtonItem = rightButtonNavBar
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
    
    private func logOutView() {
        let SplashVC = SplashViewController()
        
        self.navigationController?.navigationBar.window?.rootViewController = UINavigationController(rootViewController: SplashVC)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func onLeftHeaderButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onRightHeaderButtonClick() {
        delegate?.logOut(logOutView: logOutView)
    }
}

extension ClinicFormViewController: ClinicFormViewControllerType {
    public func updateView(with viewState: ClinicFormViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension ClinicFormViewController: ClinicFormViewDelegate {
    private func onHandleDeleteAccount(_ state: Bool) {
        if state {
            logOutView()
        }
    }
    
    public func deleteAccount() {
        delegate?.onHandleDeleteAccount(onHandleUpdated: onHandleDeleteAccount)
    }
    
    private func onHandleUpdate(_ state: Bool) {
        if !state {
            onHandleFormAlertError()
        }
    }
    public func saveNewUserInfo(user: User) {
        delegate!.onHandleUpdateClinicUserData(clinicUser: user, onHandleUpdated: onHandleUpdate)
    }
    
    public func getPlansByString(_ type: String?) -> Plans? {
        return UserHelper().getPlansByString(type)
    }
    
    public func getPlansByPlans(_ type: Plans?) -> String? {
        return UserHelper().getPlansByPlans(type)
    }
    
    public func handleFormAlert() {
        let alert = CoreAlerts().handleCreateFormAlert()
        self.present(alert, animated: true)
    }
}
