//
//  CoreHeader.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 26/07/21.
//

import UIKit

class CoreHeader {
    
    // MARK: - PARAMS

    let type: HeaderTypeOptions
    let isRightButtonAvailable: Bool
    let navigationItem: UINavigationItem
    let navigationController: UINavigationController
    let rightButton: UIButton?
    
    // MARK: - INITIALIZERS
    
    init(type: HeaderTypeOptions, isRightButtonAvailable: Bool = false, navigationItem: UINavigationItem, navigationController: UINavigationController, rightButton: UIButton?) {
        self.type = type
        self.isRightButtonAvailable = isRightButtonAvailable
        self.navigationItem = navigationItem
        self.navigationController = navigationController
        self.rightButton = rightButton
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    func setup() {
        buildLeft()
        if (isRightButtonAvailable) {
            buildRight()
        }
        addNavigationConfigs()
    }
    
    private func buildLeft() {
        let logoColorName: String
        let sublogoColorName: String
        
        switch type {
            case .main:
                logoColorName = "MainPurpleColor"
                sublogoColorName = "PurpleLightColor"
                navigationController.navigationBar.backgroundColor = .white
            case .secondary:
                logoColorName = "WhiteColor"
                sublogoColorName = "ParcialWhiteColor"
                
            case .plan:
                navigationController.navigationBar.backgroundColor = .clear
                logoColorName = "WhiteColor"
                sublogoColorName = "ParcialWhiteColor"
        }
        
        
        let logoLabel: CoreLabel = CoreLabel(type: .logo, text: "USychol", color: logoColorName)
        let sublogoLabel: CoreLabel = CoreLabel(type: .text, text: "Psychology has never been so digital", color: sublogoColorName)
        
        let leftStack = UIStackView(arrangedSubviews: [logoLabel, sublogoLabel])
        
        leftStack.alignment = .leading
        leftStack.spacing = 5
        leftStack.axis = .vertical
        
        let leftButton = UIBarButtonItem(customView: leftStack)
        
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func buildRight() {
        guard let rightButtonView = rightButton else {return}
        
        let imageButton = UIImage(named: "arrow-left-icon")
        
        rightButtonView.setImage(imageButton, for: .normal)
        
        switch type {
            case .main:
                rightButtonView.tintColor = UIColor(named: "MainPurpleColor")
            case .secondary:
                rightButtonView.tintColor = .white
            default:
                rightButtonView.tintColor = UIColor(named: "MainPurpleColor")
        }
        
        let button = UIBarButtonItem(customView: rightButtonView)
        
        navigationItem.rightBarButtonItem = button
    }
    
    private func addNavigationConfigs() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.isTranslucent = true
    }
}
