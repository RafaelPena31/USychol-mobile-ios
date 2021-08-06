
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
        let SignInVM = SignInViewModel()
        let SignInVC = SignInViewController(viewModel: SignInVM)
        
        self.navigationController?.pushViewController(SignInVC, animated: true)
    }
}
