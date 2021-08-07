
//
//  PatientFormViewController.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 06/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class PatientFormViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: PatientFormViewModelType?
    public let contentView: PatientFormViewType?

    // MARK: - PUBLIC API

    public weak var delegate: PatientFormViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: PatientFormViewType = PatientFormView(),
                viewModel: PatientFormViewModelType) {
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

extension PatientFormViewController: PatientFormViewControllerType {
    public func updateView(with viewState: PatientFormViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension PatientFormViewController: PatientFormViewDelegate {

}
