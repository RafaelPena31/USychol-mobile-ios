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
    
    // MARK: - INITIALIZERS
    
    init(type: HeaderTypeOptions, isRightButtonAvailable: Bool = false, navigationItem: UINavigationItem, navigationController: UINavigationController) {
        self.type = type
        self.isRightButtonAvailable = isRightButtonAvailable
        self.navigationItem = navigationItem
        self.navigationController = navigationController
        
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
        case .secondary:
            logoColorName = "WhiteColor"
            sublogoColorName = "ParcialWhiteColor"
        }
        
        let logoLabel: UILabel = CoreLabel(type: .logo, text: "USychol", color: logoColorName)
        let sublogoLabel: UILabel = CoreLabel(type: .text, text: "Psychology has never been so digital", color: sublogoColorName)
        
        let leftStack = UIStackView(arrangedSubviews: [logoLabel, sublogoLabel])
        
        leftStack.alignment = .leading
        leftStack.spacing = 5
        leftStack.axis = .vertical
        
        let leftButton = UIBarButtonItem(customView: leftStack)
        
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func buildRight() {
        let button = UIButton()
        
        let imageButton = UIImage(named: "arrow-left-icon")
        
        button.setImage(imageButton, for: .normal)
        button.tintColor = .white
        
        let rightButton = UIBarButtonItem(customView: button)
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func addNavigationConfigs() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .always
    }
}
