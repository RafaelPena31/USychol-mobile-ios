
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
}

extension FullPlanViewController: FullPlanViewControllerType {
    public func updateView(with viewState: FullPlanViewState) {
        contentView?.updateView(with: viewState)
    }
    
    public func onHandleClick() {
        let PatientHallVM = NewReportViewModel()
        let PatientHallVC = NewReportViewController(viewModel: PatientHallVM)
        
        self.navigationController?.pushViewController(PatientHallVC, animated: true)
    }
    
    public func onHandleTouch() {
        let VirtualPlanVM = VirtualPlanViewModel()
        let VirtualPlanVC = VirtualPlanViewController(viewModel: VirtualPlanVM)
        
        self.navigationController?.pushViewController(VirtualPlanVC, animated: true)
    }
}

extension FullPlanViewController: FullPlanViewDelegate {

}
