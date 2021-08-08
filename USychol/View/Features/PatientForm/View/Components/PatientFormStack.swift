//
//  PatientFormStack.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 07/08/21.
//

import UIKit

final class PatientFormStack: UIStackView {
    
    // MARK: - UI
    
    private lazy var identificationDividerLabel: CoreDividerLabel = {
        let label = CoreDividerLabel(text: "Patient Registration", iconName: "profile-icon")
        
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
    
    private lazy var patientClassTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Patient Class", labelText: "Patient Class")
        
        return input
    }()
    
    private lazy var motherTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Mother's Name", labelText: "Mother's Name")
        
        return input
    }()
    
    private lazy var fatherTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Father's Name", labelText: "Father's Name")
        
        return input
    }()
    
    private lazy var maritalTextField: CoreInputField = {
        let input = CoreInputField(placeholder: "Marital Status", labelText: "Marital Status")
        
        return input
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
        self.addArrangedSubview(identificationDividerLabel)
        self.addArrangedSubview(nameTextField)
        self.addArrangedSubview(ageTextField)
        self.addArrangedSubview(patientClassTextField)
        self.addArrangedSubview(motherTextField)
        self.addArrangedSubview(fatherTextField)
        self.addArrangedSubview(maritalTextField)
    }
    
    private func buildStyle() {
        self.axis = .vertical
        self.spacing = 16
        self.alignment = .leading
    }
    
    private func addConstraints() {
        nameTextField.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
        
        ageTextField.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
        
        patientClassTextField.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
        
        motherTextField.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
        
        fatherTextField.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
        
        maritalTextField.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
    }
}
