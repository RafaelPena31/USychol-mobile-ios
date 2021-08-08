//
//  ClinicFormStack.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 07/08/21.
//

import UIKit

final class ClinicFormStack: UIStackView {
    
    // MARK: - UI
    
    private lazy var identificationDividerLabel: CoreDividerLabel = {
        let label = CoreDividerLabel(text: "Identification", iconName: "profile-icon")
        
        return label
    }()
    
    private lazy var nameTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Name", labelText: "Name")
        
        return input
    }()
    
    private lazy var ageTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Age", labelText: "Age")
        
        return input
    }()
    
    private lazy var emailTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Email", labelText: "Email")
        
        return input
    }()
    
    private lazy var crpTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "CRP", labelText: "CRP")
        
        return input
    }()
    
    private lazy var cpfTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "CPF", labelText: "CPF")
        
        return input
    }()
    
    private lazy var identificationFormStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [identificationDividerLabel, nameTextField, ageTextField, emailTextField, crpTextField, cpfTextField])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        
        return stack
    }()
    
    private lazy var planDividerLabel: CoreDividerLabel = {
        let label = CoreDividerLabel(text: "Plan", iconName: "list-icon")
        
        return label
    }()
    
    private lazy var planNameTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Plan's name", labelText: "Plan's name")
        
        return input
    }()
    
    private lazy var expirationDayTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Expiration day", labelText: "Expiration day")
        
        return input
    }()
    
    private lazy var planFormStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [planDividerLabel, planNameTextField, expirationDayTextField])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        
        return stack
    }()
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        buildHierarchy()
        addConstraints()
        buildStyle()
    }
    
    private func buildHierarchy() {
        self.addArrangedSubview(identificationFormStack)
        self.addArrangedSubview(planFormStack)
    }
    
    private func buildStyle() {
        self.axis = .vertical
        self.spacing = 16
        self.alignment = .leading
    }
    
    private func addConstraints() {
        nameTextField.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        ageTextField.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        emailTextField.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        crpTextField.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        cpfTextField.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        planNameTextField.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        expirationDayTextField.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        identificationFormStack.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        planFormStack.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
    }
}
