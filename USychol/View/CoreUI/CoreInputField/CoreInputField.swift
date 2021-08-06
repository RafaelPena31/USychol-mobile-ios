//
//  CoreInputField.swift
//  USychol
//
//  Created by Fernando Rodrigues on 29/07/21.
//

import UIKit

final public class CoreInputField: UIView  {
    // MARK: - PARAMS

    let inputPlaceholder: String
    let labelText: String
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, placeholder: String, labelText: String){
        self.inputPlaceholder = placeholder
        self.labelText = labelText

        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    let inputField: UITextField = {
        let input = UITextField()
        return input
    }()
    
    let label: UILabel = {
       let label = CoreLabel(type: .labelInput, text: "Email", color: "GreyLabelColor")
        return label
    }()
    
    // MARK: - PRIVATE
    
    private func setup(){
        applyContent()
        buildHierarchy()
        buildConstraints()
    }
    
    private func applyContent(){
        inputField.placeholder = self.inputPlaceholder
        label.text = self.labelText
    }
    
    private func buildHierarchy(){
        self.addSubview(label)
        self.addSubview(inputField)
    }
    
    private func buildConstraints(){
        inputField.snp.makeConstraints{(make) -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0))
            make.height.equalTo(34)
        }
        
        label.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(inputField).inset(UIEdgeInsets(top: -64, left: 0, bottom: 0, right: 0))
        }
    }
}
