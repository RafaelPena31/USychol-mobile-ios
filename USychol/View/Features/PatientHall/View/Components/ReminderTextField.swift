//
//  ReminderTextField.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 29/07/21.
//

import UIKit
import SnapKit

final class ReminderTextField: UITextField {
    // MARK: - PARAMS

    let insets: UIEdgeInsets
    let onHandleClickAdd: () -> Void
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, insets: UIEdgeInsets, placeholder: String, onHandleClickAdd: @escaping () -> Void) {
        self.insets = insets
        self.onHandleClickAdd = onHandleClickAdd
        
        super.init(frame: frame)
        
        setup(placeholder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - NATIVE METHODS
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    // MARK: - IMPLEMENTED METHODS
    
    public func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        iconView.tintColor = UIColor(named: "GreyPlaceholderColor")
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    public func setButton(_ image: UIImage) {
        let button = UIButton(frame: CGRect(x: 0, y: 3, width: 25, height: 25))
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: "MainPurpleColor")
        
        button.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(button)
        
        rightView = iconContainerView
        rightViewMode = .always
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setup(_ placeholder: String) {
        buildUI(placeholder: placeholder)
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildUI(placeholder: String) {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "MainPurpleColor")?.cgColor
        
        self.placeholder = placeholder
        self.backgroundColor = UIColor(named: "WhiteColor")
    }
    
    private func buildViewHierarchy() {
        setIcon(UIImage(named: "plus-icon")!)
        setButton(UIImage(named: "arrow-right-icon")!)
        self.font = UIFont(name: "Inter-Regular", size: 12)
    }
    
    private func addConstraints() {
        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
        }
    }
    
    // MARK: - PRIVATE ACTIONS
    
    @objc private func onClickButton() {
        onHandleClickAdd()
    }
}

