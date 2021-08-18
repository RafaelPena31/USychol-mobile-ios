
//
//  PatientProfileViewController.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class PatientProfileViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: PatientProfileViewModelType?
    public let contentView: PatientProfileViewType?
    
    // MARK: - PUBLIC API

    public weak var delegate: PatientProfileViewControllerDelegate?
    public weak var viewDelegate: PatientProfileViewControllerViewDelegate?
    public weak var handleStateChange: PatientProfileBackStateChangeControl?

    // MARK: - INITIALIZERS

    public init(contentView: PatientProfileViewType = PatientProfileView(),
                viewModel: PatientProfileViewModelType) {
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
    
    private func headerSetup(_ title: String = "") {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainPurpleColor")
        
        let title = CoreLabel(type: .title, text: title, color: "WhiteColor")
        let subtitle = CoreLabel(type: .cardText, text: "Latest consultations", color: "StrongParcialWhiteColor")
        
        let stack = UIStackView(arrangedSubviews: [title, subtitle])
        
        stack.alignment = .center
        stack.axis = .vertical
        
        self.navigationItem.titleView = stack
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 20)!]
        
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
    
    private func handleErrorAlert(title: String, message: String) {
        let alert = CoreAlerts().handleErrorAlert(title: title, message: message, buttonText: "Continue")
        self.present(alert, animated: true)
    }
    
    // MARK: - ACTIONS
    
    @objc func onLeftHeaderButtonClick() {
        handleStateChange?.handleStateChange()
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension PatientProfileViewController: PatientProfileViewControllerType {
    public func updateView(with viewState: PatientProfileViewState) {
        switch viewState {
        case .hasData(let entity):
            headerSetup(entity.patient.name)
        default:
            break
        }

        contentView?.updateView(with: viewState)
    }
}

extension PatientProfileViewController: PatientProfileViewDelegate {
    public func onHandleAccessAnamnesis() {
        let PatientAnamnesisVM = PatientAnamnesisViewModel()
        let PatientAnamnesisVC = PatientAnamnesisViewController(viewModel: PatientAnamnesisVM)
        
        PatientAnamnesisVM.viewController = PatientAnamnesisVC
        PatientAnamnesisVC.delegate = PatientAnamnesisVM
        
        self.navigationController?.pushViewController(PatientAnamnesisVC, animated: true)
    }
    
    public func onHandleAccessReport(report: Report) {
        if delegate!.setCurrentReport(report: report) {
            let PatientReportVM = PatientReportViewModel()
            let PatientReportVC = PatientReportViewController(viewModel: PatientReportVM)
            
            PatientReportVM.viewController = PatientReportVC
            
            self.navigationController?.pushViewController(PatientReportVC, animated: true)
        } else {
            handleErrorAlert(title: "Heads up", message: "It was not possible to access your report's patient, please contact the USychol Team support team")
        }
    }
    
    public func onHandleCreateActivy() {
        let NewActivityVM = NewActivityViewModel()
        let NewActivityVC = NewActivityViewController(viewModel: NewActivityVM)
        
        NewActivityVM.viewController = NewActivityVC
        NewActivityVC.delegate = NewActivityVM
        
        self.navigationController?.pushViewController(NewActivityVC, animated: true)
    }
    
    public func onHandleCreateReport() {
        let NewReportVM = NewReportViewModel()
        let NewReportVC = NewReportViewController(viewModel: NewReportVM)
        
        NewReportVM.viewController = NewReportVC
        NewReportVC.delegate = NewReportVM
        NewReportVC.handleStateChange = self
        
        self.navigationController?.pushViewController(NewReportVC, animated: true)
    }
    
    public func onHandleSearchReport() {
        print("onHandleSearchReport")
    }
}

extension PatientProfileViewController: NewReportBackStateChangeControl {
    public func NewReportHandleStateChange() {
        viewModel?.updateState()
        viewDelegate?.reloadData()
    }
}
