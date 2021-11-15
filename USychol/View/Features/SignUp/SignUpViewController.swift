
//
//  SignUpViewController.swift
//  USychol
//
//  Created Fernando Rodrigues on 30/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import RxSwift

public class SignUpViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: SignUpViewModelType?
    public let contentView: SignUpViewType?
    let disposeBag = DisposeBag()

    // MARK: - PUBLIC API

    public weak var delegate: SignUpViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: SignUpViewType = SignUpView(),
                viewModel: SignUpViewModelType) {
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
        bindObservables()
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        contentSetup()
        headerSetup()
    }
    
    private func headerSetup() {
        _ = CoreHeader(type: .main, isRightButtonAvailable: true, navigationItem: self.navigationItem, navigationController: self.navigationController!, rightButton: nil)
    }
    
    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
    
    private func bindObservables() {
        viewModel?.viewSignUpObservable.subscribe(onNext: { [weak self] event in
            self?.onAuthStateChange(event)
        }).disposed(by: disposeBag)
    }
}

extension SignUpViewController: SignUpViewControllerType {
    public func updateView(with viewState: SignUpViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension SignUpViewController: SignUpViewDelegate {
    public func onHandleFormAlert() {
        let alert = CoreAlerts().handleDefaultAlert(title: "USychol", message: "Fill in all fields with valid data", buttonText: "Continue")
        self.present(alert, animated: true)
    }
    
    private func onAuthStateChange(_ authStatus: EnumAuthResponse) {
        switch authStatus {
        case .authenticated:
            let VirtualPlanVM = VirtualPlanViewModel()
            let VirtualPlanVC = VirtualPlanViewController(viewModel: VirtualPlanVM)
            
            VirtualPlanVM.viewController = VirtualPlanVC
            VirtualPlanVC.delegate = VirtualPlanVM
            
            self.navigationController?.pushViewController(VirtualPlanVC, animated: true)
            break
        case .unauthenticated:
            let alert = CoreAlerts().handleDefaultAlert(title: "Heads up", message: "Unable to register, contact USychol Team support", buttonText: "Continue")
            self.present(alert, animated: true)
            break
        case .error(let err):
            let alert = CoreAlerts().handleErrorAlert(title: "Heads up", message: "Error: \(err) Contact USychol Team support", buttonText: "Continue")
            self.present(alert, animated: true)
            break
        }
    }
    
    public func onHandleClick(user: User) {
        viewModel?.onHandleSignUp(user: user)
    }
    
    public func onHandleChange() {
        self.navigationController?.popViewController(animated: true)
    }
}
