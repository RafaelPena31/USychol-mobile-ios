
//
//  SignInViewController.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 28/07/21.
//

import UIKit

public class SignInViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: SignInViewModelType?
    public let contentView: SignInViewType?

    // MARK: - PUBLIC API

    public weak var delegate: SignInViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: SignInViewType = SignInView(),
                viewModel: SignInViewModelType) {
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
        _ = CoreHeader(type: .main, navigationItem: self.navigationItem, navigationController: self.navigationController!, rightButton: nil)
        contentSetup()
    }
    
    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
}

extension SignInViewController: SignInViewControllerType {
    public func updateView(with viewState: SignInViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension SignInViewController: SignInViewDelegate {

}
