
//
//  SignUpViewController.swift
//  USychol
//
//  Created Fernando Rodrigues on 30/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class SignUpViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: SignUpViewModelType?
    public let contentView: SignUpViewType?

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
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: SignUpViewControllerType {
    public func updateView(with viewState: SignUpViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension SignUpViewController: SignUpViewDelegate {
    public func onHandleClick() {
        let VirtualPlanVM = VirtualPlanViewModel()
        let VirtualPlanVC = VirtualPlanViewController(viewModel: VirtualPlanVM)
        
        self.navigationController?.pushViewController(VirtualPlanVC, animated: true)
    }
    
    public func onHandleChange() {
        let SignInVM = SignInViewModel()
        let SignInVC = SignInViewController(viewModel: SignInVM)
        
        self.navigationController?.pushViewController(SignInVC, animated: true)
    }
}
