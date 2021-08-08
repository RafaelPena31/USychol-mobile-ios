
//
//  VirtualPlanViewController.swift
//  USychol
//
//  Created Fernando Rodrigues on 06/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class VirtualPlanViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: VirtualPlanViewModelType?
    public let contentView: VirtualPlanViewType?

    // MARK: - PUBLIC API

    public weak var delegate: VirtualPlanViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: VirtualPlanViewType = VirtualPlanView(),
                viewModel: VirtualPlanViewModelType) {
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
}

extension VirtualPlanViewController: VirtualPlanViewControllerType {
    public func updateView(with viewState: VirtualPlanViewState) {
        contentView?.updateView(with: viewState)
    }
    
    public func onHandleClick() {
        let PatientHallVM = PatientHallViewModel()
        let PatientHallVC = PatientHallViewController(viewModel: PatientHallVM)
        
        PatientHallVM.viewController = PatientHallVC
        
        self.navigationController?.pushViewController(PatientHallVC, animated: true)
    }
    
    public func onHandleTouch() {
        let DigitalPlanVM = DigitalPlanViewModel()
        let DigitalPlanVC = DigitalPlanViewController(viewModel: DigitalPlanVM)
        
        DigitalPlanVM.viewController = DigitalPlanVC
        
        self.navigationController?.pushViewController(DigitalPlanVC, animated: true)
    }
}

extension VirtualPlanViewController: VirtualPlanViewDelegate {

}
