
//
//  SignInViewController.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 28/07/21.
//

import UIKit
import RxSwift

public class SignInViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: SignInViewModelType?
    public let contentView: SignInViewType?
    let disposeBag = DisposeBag()

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
        bindObservables()
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
    
    private func bindObservables() {
        viewModel?.viewSignInObservable.subscribe(onNext: { [weak self] event in
            self?.onAuthStateChange(event)
        }).disposed(by: disposeBag)
    }
    
    private let baseUrl = "https://6155212b2473940017efb080.mockapi.io/usychol/api/v1/users"
    private let urlSession = URLSession.shared
}

extension SignInViewController: SignInViewControllerType {
    public func updateView(with viewState: SignInViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension SignInViewController: SignInViewDelegate {
    public func onHandleFormAlert() {
        let alert = CoreAlerts().handleDefaultAlert(title: "USychol", message: "Fill in all fields with valid data", buttonText: "Continue")
        self.present(alert, animated: true)
    }
    
    private func onAuthStateChange(_ authStatus: EnumAuthResponse) {
        switch authStatus {
        case .authenticated:
            let userInfo = delegate!.getCurrentUserInfo()
            let plan = userInfo.userInfo.plan
            
            if plan != nil {
                let PatientHallVM = PatientHallViewModel()
                let PatientHallVC = PatientHallViewController(viewModel: PatientHallVM)
                
                PatientHallVM.viewController = PatientHallVC
                PatientHallVC.delegate = PatientHallVM
                PatientHallVC.viewDelegate = PatientHallVC.contentView
                
                self.navigationController?.pushViewController(PatientHallVC, animated: true)
            } else {
                let VirtualPlanVM = VirtualPlanViewModel()
                let VirtualPlanVC = VirtualPlanViewController(viewModel: VirtualPlanVM)
                
                VirtualPlanVM.viewController = VirtualPlanVC
                VirtualPlanVC.delegate = VirtualPlanVM
                
                self.navigationController?.pushViewController(VirtualPlanVC, animated: true)
            }
            break
        case .unauthenticated:
            let alert = CoreAlerts().handleDefaultAlert(title: "Heads up", message: "Incorrect email or password, check data and try again", buttonText: "Continue")
            self.present(alert, animated: true)
            break
        case .error(let err):
            let alert = CoreAlerts().handleErrorAlert(title: "Heads up", message: "Error: \(err), contact USychol Team support", buttonText: "Continue")
            self.present(alert, animated: true)
            break
        }
    }
    
    public func onHandleClick(email: String, password: String) {
        viewModel?.onHandleSignIn(email: email, password: password)
    }
    
    public func onHandleChange() {
        let SignUpVM = SignUpViewModel()
        let SignUpVC = SignUpViewController(viewModel: SignUpVM)
        
        SignUpVM.viewController = SignUpVC
        SignUpVC.delegate = SignUpVM
        
        self.navigationController?.pushViewController(SignUpVC, animated: true)
    }
}

