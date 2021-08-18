
//
//  PatientHallViewController.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 29/07/21.
//
//

import UIKit

public class PatientHallViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: PatientHallViewModelType?
    public let contentView: PatientHallViewType?

    // MARK: - PUBLIC API

    public weak var delegate: PatientHallViewControllerDelegate?
    public weak var viewDelegate: PatientHallViewControllerViewDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: PatientHallViewType = PatientHallView(), viewModel: PatientHallViewModelType) {
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
        
        self.title = "Tasks of the day"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 20)!]
        
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "profile-icon"), for: .normal)
        leftButton.tintColor = .white
        
        leftButton.addTarget(self, action: #selector(onLeftHeaderButtonClick), for: .touchUpInside)
        
        let leftButtonNavBar = UIBarButtonItem(customView: leftButton)
        
        navigationItem.leftBarButtonItem = leftButtonNavBar
        
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "plus-icon"), for: .normal)
        rightButton.tintColor = .white
        
        rightButton.addTarget(self, action: #selector(onRightHeaderButtonClick), for: .touchUpInside)
        
        let rightButtonNavBar = UIBarButtonItem(customView: rightButton)
        
        navigationItem.rightBarButtonItem = rightButtonNavBar
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
        let ClinicFormVM = ClinicFormViewModel()
        let ClinicFormVC = ClinicFormViewController(viewModel: ClinicFormVM)
        
        ClinicFormVM.viewController = ClinicFormVC
        ClinicFormVC.delegate = ClinicFormVM
        
        self.navigationController?.pushViewController(ClinicFormVC, animated: true)
    }
    
    @objc func onRightHeaderButtonClick() {
        let PatientFormVM = PatientFormViewModel()
        let PatientFormVC = PatientFormViewController(viewModel: PatientFormVM)
        
        PatientFormVM.viewController = PatientFormVC
        PatientFormVC.delegate = PatientFormVM
        PatientFormVC.handleStateChange = self
        
        self.navigationController?.pushViewController(PatientFormVC, animated: true)
    }
}

extension PatientHallViewController: PatientHallViewControllerType {
    public func updateView(with viewState: PatientHallViewState) {
        print("controller")
        contentView?.updateView(with: viewState)
    }
}

extension PatientHallViewController: PatientHallViewDelegate {
    public func onHandleErrorAlert() {
        let alert = CoreAlerts().handleDefaultAlert(title: "USychol", message: "Fill in all fields with valid data", buttonText: "Continue")
        self.present(alert, animated: true)
    }
    
    public func onHandlePatientProfileRedirect(patient: Patient) {
        if delegate!.setCurrentPatient(patient: patient) {
            let PatientProfileVM = PatientProfileViewModel()
            let PatientProfileVC = PatientProfileViewController(viewModel: PatientProfileVM)
            
            PatientProfileVM.viewController = PatientProfileVC
            PatientProfileVC.delegate = PatientProfileVM
            PatientProfileVC.handleStateChange = self
            PatientProfileVC.viewDelegate = PatientProfileVC.contentView
            
            self.navigationController?.pushViewController(PatientProfileVC, animated: true)
        } else {
            handleErrorAlert(title: "Heads up", message: "It was not possible to access your patient, please contact the USychol Team support team")
        }
    }
    
    public func onHandleAddReminder(_ text: String) {
        let updateStatus = delegate!.onHandleAddReminder(text)
        
        if !updateStatus {
            handleErrorAlert(title: "Heads up", message: "It was not possible to create your reminder, please contact the USychol Team support team")
        } else {
            handleStateChange()
        }
    }
}

extension PatientHallViewController: PatientFormBackStateChangeControl, PatientProfileBackStateChangeControl {
    public func handleStateChange() {
        viewModel?.updateState()
        viewDelegate?.reloadData()
    }
}
