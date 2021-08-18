//
//  ClinicFormStack.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 07/08/21.
//

import UIKit

final class ClinicFormStack: UIStackView {
    // MARK: - PARAMS
    
    var clinicUser: User?
    
    // MARK: - UI
    
    public lazy var identificationDividerLabel: CoreDividerLabel = {
        let label = CoreDividerLabel(text: "Identification", iconName: "profile-icon")
        
        return label
    }()
    
    public lazy var nameTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Name", labelText: "Name", initText: clinicUser?.name, isEnabled: false)
        
        return input
    }()
    
    public lazy var ageTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Age", labelText: "Age", keyboardType: .numberPad, initText: clinicUser?.age, isEnabled: false)
        
        return input
    }()
    
    public lazy var emailTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Email", labelText: "Email", keyboardType: .emailAddress, initText: clinicUser?.email, isEnabled: false)
        
        return input
    }()
    
    public lazy var crpTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "CRP", labelText: "CRP", keyboardType: .numberPad, initText: clinicUser?.crp, isEnabled: false)
        
        return input
    }()
    
    public lazy var cpfTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "CPF", labelText: "CPF", keyboardType: .numberPad, initText: clinicUser?.cpf, isEnabled: false)
        
        return input
    }()
    
    public lazy var identificationFormStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [identificationDividerLabel, nameTextField, ageTextField, emailTextField, crpTextField, cpfTextField])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        
        return stack
    }()
    
    public lazy var planDividerLabel: CoreDividerLabel = {
        let label = CoreDividerLabel(text: "Plan", iconName: "list-icon")
        
        return label
    }()
    
    public lazy var planNameTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Plan's name", labelText: "Plan's name", isEnabled: false)
        
        return input
    }()
    
    public lazy var expirationDayTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Expiration day", labelText: "Expiration day", keyboardType: .numberPad, isEnabled: false)
        
        return input
    }()
    
    public lazy var planFormStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [planDividerLabel, planNameTextField, expirationDayTextField])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        
        return stack
    }()
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, clinicUser: User?) {
        self.clinicUser = clinicUser
        
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
