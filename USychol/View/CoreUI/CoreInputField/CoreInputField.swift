//
//  CoreInputField.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 07/08/21.
//

import UIKit

final public class CoreInputField: UIStackView  {
    
    // MARK: - PARAMS
    
    let inputPlaceholder: String
    let labelText: String
    let height: Int
    
    // MARK: - UI
    
    public lazy var inputField: TextField = {
        let input = TextField()
        
        let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        input.placeholder = inputPlaceholder
        input.backgroundColor = UIColor(named: "GreyLightColor")
        input.layer.cornerRadius = 8
        
        return input
    }()

    public lazy var label: UILabel = {
        let label = CoreLabel(type: .labelInput, text: labelText, color: "GreyLabelColor")
        
        return label
    }()
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, placeholder: String, labelText: String, height: Int = 55){
        self.inputPlaceholder = placeholder
        self.labelText = labelText
        self.height = height

        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - PRIVATE
    
    private func setup(){
        buildHierarchy()
        buildStyle()
        addConstraints()
    }

    private func buildHierarchy() {
        self.addArrangedSubview(label)
        self.addArrangedSubview(inputField)
    }
    
    private func buildStyle() {
        self.axis = .vertical
        self.alignment = .leading
        self.spacing = 8
    }

    private func addConstraints(){
        inputField.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(self.height)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
}
