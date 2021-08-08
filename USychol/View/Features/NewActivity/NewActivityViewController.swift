
//
//  NewActivityViewController.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class NewActivityViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: NewActivityViewModelType?
    public let contentView: NewActivityViewType?

    // MARK: - PUBLIC API

    public weak var delegate: NewActivityViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: NewActivityViewType = NewActivityView(),
                viewModel: NewActivityViewModelType) {
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

extension NewActivityViewController: NewActivityViewControllerType {
    public func updateView(with viewState: NewActivityViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension NewActivityViewController: NewActivityViewDelegate {

}
