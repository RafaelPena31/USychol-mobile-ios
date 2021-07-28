//
//  Button.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 22/07/21.
//

import UIKit
import SnapKit


final public class CoreButton: UIButton {
    
    // MARK: - PARAMS

    let type: ButtonModeOptions
    let onPressMethod: () -> Void
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, type: ButtonModeOptions, title: String, onPressMethod: @escaping () -> Void) {
        self.type = type
        self.onPressMethod = onPressMethod
        
        super.init(frame: frame)
        setup(title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setup(_ titleText: String) {
        setAttributes(titleText)
        setActions()
        applyStyle()
    }
    
    private func applyStyle() {
        switch type {
        case .dark:
            self.backgroundColor = UIColor(named: "NeonLightBlackColor")
            self.setTitleColor(UIColor(named: "WhiteColor"), for: .normal)
        case .light:
            self.backgroundColor = UIColor(named: "WhiteColor")
            self.setTitleColor(UIColor(named: "MainPurpleColor"), for: .normal)
        case .normal:
            self.backgroundColor = UIColor(named: "MainPurpleColor")
            self.setTitleColor(UIColor(named: "WhiteColor"), for: .normal)
        }
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 20)
        
    }
    
    private func setAttributes(_ titleText: String) {
        self.setTitle(titleText, for: .normal)
    }
    
    private func setActions() {
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    @objc private func onPress() {
        self.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.alpha = 1.0
        }
        
        onPressMethod()
    }
}
