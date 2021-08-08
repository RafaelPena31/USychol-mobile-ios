
//
//  DigitalPlanViewController.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class DigitalPlanViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: DigitalPlanViewModelType?
    public let contentView: DigitalPlanViewType?

    // MARK: - PUBLIC API

    public weak var delegate: DigitalPlanViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: DigitalPlanViewType = DigitalPlanView(),
                viewModel: DigitalPlanViewModelType) {
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
    
    public func onHandleClick() {
        let PatientHallVM = PatientHallViewModel()
        let PatientHallVC = PatientHallViewController(viewModel: PatientHallVM)
        
        PatientHallVM.viewController = PatientHallVC
        
        self.navigationController?.pushViewController(PatientHallVC, animated: true)
    }
    
    public func onHandleTouch() {
        let FullPlanVM = FullPlanViewModel()
        let FullPlanVC = FullPlanViewController(viewModel: FullPlanVM)
        
        FullPlanVM.viewController = FullPlanVC
        
        self.navigationController?.pushViewController(FullPlanVC, animated: true)
    }
}

extension DigitalPlanViewController: DigitalPlanViewControllerType {
    public func updateView(with viewState: DigitalPlanViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension DigitalPlanViewController: DigitalPlanViewDelegate {

}
