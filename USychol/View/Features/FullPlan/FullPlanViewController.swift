
//
//  FullPlanViewController.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class FullPlanViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: FullPlanViewModelType?
    public let contentView: FullPlanViewType?

    // MARK: - PUBLIC API

    public weak var delegate: FullPlanViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: FullPlanViewType = FullPlanView(),
                viewModel: FullPlanViewModelType) {
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
    
    private func headerSetup(){
        _ = CoreHeader(type: .plan, navigationItem: self.navigationItem, navigationController: self.navigationController!, rightButton: nil)
    }

    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
    
    private func onHandleFormAlert() {
        let alert = CoreAlerts().handleDefaultAlert(title: "USychol", message: "Unable to assign this plan to your profile, contact the USychol Team support team", buttonText: "Continue")
        self.present(alert, animated: true)
    }
}

extension FullPlanViewController: FullPlanViewControllerType {
    public func updateView(with viewState: FullPlanViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension FullPlanViewController: FullPlanViewDelegate {
    private func onHandleSetPlan(_ updateStatus: Bool) {
        if updateStatus {
            let PatientHallVM = PatientHallViewModel()
            let PatientHallVC = PatientHallViewController(viewModel: PatientHallVM)
            
            PatientHallVM.viewController = PatientHallVC
            PatientHallVC.delegate = PatientHallVM
            PatientHallVC.viewDelegate = PatientHallVC.contentView
            
            self.navigationController?.pushViewController(PatientHallVC, animated: true)
        } else {
            onHandleFormAlert()
        }
    }
    
    public func onHandleClick() {
        delegate!.setPlan(onHandleSetPlan)
    }
    
    public func onHandleTouch() {
        let VirtualPlanVM = VirtualPlanViewModel()
        let VirtualPlanVC = VirtualPlanViewController(viewModel: VirtualPlanVM)
        
        VirtualPlanVM.viewController = VirtualPlanVC
        VirtualPlanVC.delegate = VirtualPlanVM
        
        self.navigationController?.pushViewController(VirtualPlanVC, animated: true)
    }
}
