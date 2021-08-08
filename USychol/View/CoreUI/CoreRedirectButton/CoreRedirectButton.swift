//
//  CoreRedirectButton.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 07/08/21.
//

import UIKit

final class CoreRedirectButton: UIButton {
    
    // MARK: - PARAMS
    
    let leftIconName: String
    let title: String
    let onPressMethod: () -> Void
    
    // MARK: - UI
    
    
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, leftIconName: String, title: String, onPressMethod: @escaping () -> Void) {
        self.leftIconName = leftIconName
        self.title = title
        self.onPressMethod = onPressMethod
        
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        buildHierarchy()
        buildStyle()
        setAttributes()
        setActions()
    }
    
    private func buildHierarchy() {
        let leftIcon = UIImage(named: leftIconName)
        
        self.setImage(leftIcon, for: .normal)
        self.tintColor = UIColor(named: "GreyPlaceholderColor")

        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 8)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: (imageView?.frame.width)!, bottom: 0, right: 10)
        self.contentHorizontalAlignment = .left
    }
    
    private func buildStyle() {
        self.backgroundColor = .white
        self.setTitleColor(UIColor(named: "GreyPlaceholderColor"), for: .normal)
        
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "MainPurpleColor")?.cgColor
    }
    
    private func setAttributes() {
        self.setTitle(title, for: .normal)
    }
    
    private func setActions() {
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    // MARK: - ACTIONS
    
    @objc private func onPress() {
        self.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.alpha = 1.0
        }

        onPressMethod()
    }
}
