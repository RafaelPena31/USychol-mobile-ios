
//
//  PatientHallViewController.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 29/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

public class PatientHallViewController: UIViewController {

    // MARK: - PROPERTIES

    public let viewModel: PatientHallViewModelType?
    public let contentView: PatientHallViewType?

    // MARK: - PUBLIC API

    public weak var delegate: PatientHallViewControllerDelegate?

    // MARK: - INITIALIZERS

    public init(contentView: PatientHallViewType = PatientHallView(),
                viewModel: PatientHallViewModelType) {
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
        
        let leftButtonNavBar = UIBarButtonItem(customView: leftButton)
        
        navigationItem.leftBarButtonItem = leftButtonNavBar
        
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "plus-icon"), for: .normal)
        rightButton.tintColor = .white
        
        let rightButtonNavBar = UIBarButtonItem(customView: rightButton)
        
        navigationItem.rightBarButtonItem = rightButtonNavBar
    }
    
    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
}

extension PatientHallViewController: PatientHallViewControllerType {
    public func updateView(with viewState: PatientHallViewState) {
        contentView?.updateView(with: viewState)
    }
}

extension PatientHallViewController: PatientHallViewDelegate {
    public func onHandleAddReminder() {
        print("onHandleAddReminder")
    }
}
