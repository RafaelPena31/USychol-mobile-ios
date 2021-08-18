
//
//  PatientFormViewController.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 06/08/21.
//
//

import UIKit

public class PatientFormViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: PatientFormViewModelType?
    public let contentView: PatientFormViewType?

    // MARK: - PUBLIC API

    public weak var delegate: PatientFormViewControllerDelegate?
    public weak var handleStateChange: PatientFormBackStateChangeControl?

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
        headerSetup()
        contentSetup()
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
    
    public func onHandleFormAlertError() {
        let alert = CoreAlerts().handleDefaultAlert(title: "USychol", message: "Unable to create your patient, please contact the USychol Team support team", buttonText: "Continue")
        self.present(alert, animated: true)
    }
    
    // MARK: - ACTIONS
    
    @objc func onRightHeaderButtonClick() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension PatientFormViewController: PatientFormViewControllerType {
    public func updateView(with viewState: PatientFormViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension PatientFormViewController: PatientFormViewDelegate {
    public func onHandleCreatePatient(patient: Patient) {
        let updateStatus = delegate!.onHandleCreatePatient(patient: patient)
        
        if updateStatus {
            handleStateChange?.handleStateChange()
            onRightHeaderButtonClick()
        } else {
            onHandleFormAlertError()
        }
    }
}
