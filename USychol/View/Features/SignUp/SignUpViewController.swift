
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
        _ = CoreHeader(type: .main, isRightButtonAvailable: true, navigationItem: self.navigationItem, navigationController: self.navigationController!, rightButton: nil)
    }
    
    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
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
        
        VirtualPlanVM.viewController = VirtualPlanVC
        
        self.navigationController?.pushViewController(VirtualPlanVC, animated: true)
    }
    
    public func onHandleChange() {
        self.navigationController?.popViewController(animated: true)
    }
}