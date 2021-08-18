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
    let isEnabled: Bool
    let height: Int
    let keyboardType: UIKeyboardType
    let initText: String?
    let onHandleClickInput: (() -> Void)?
    
    // MARK: - UI
    
    private lazy var inputField: TextField = {
        let input = TextField()
        
        input.backgroundColor = UIColor(named: "GreyLightColor")
        input.layer.cornerRadius = 8
        
        input.placeholder = inputPlaceholder
        input.text = initText
        
        input.isEnabled = isEnabled
        input.keyboardType = keyboardType
        
        input.addTarget(self, action: #selector(onHandleChangeText), for: .editingChanged)
        input.addTarget(self, action: #selector(onHandleClick), for: .touchUpInside)
        
        return input
    }()

    private lazy var label: UILabel = {
        let label = CoreLabel(type: .labelInput, text: labelText, color: "GreyLabelColor")
        
        return label
    }()
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, placeholder: String, labelText: String, height: Int = 55, keyboardType: UIKeyboardType = .default, initText: String? = "", isEnabled: Bool = true, onHandleClickInput: @escaping (() -> Void) = {()}){
        self.inputPlaceholder = placeholder
        self.labelText = labelText
        self.height = height
        self.keyboardType = keyboardType
        self.initText = initText
        self.isEnabled = isEnabled
        self.onHandleClickInput = onHandleClickInput

        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - GET/SET
    
    var text: String = ""
    
    public func setText(_ text: String) {
        inputField.text = text
    }
    
    public func setIsEnable(_ isEnabled: Bool = true) {
        inputField.isEnabled = isEnabled
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
    
    // MARK: - ACTIONS
    
    @objc func onHandleChangeText() {
        text = inputField.text ?? ""
    }
    
    @objc func onHandleClick() {
        guard let onHandleClickInput = onHandleClickInput else {
            return
        }
        
        onHandleClickInput()
        print("clicou")
    }
}
