//
//  CoreLabel.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 26/07/21.
//

import UIKit

final public class CoreLabel: UILabel {
    
    // MARK: - PARAMS

    let type: LabelTypeOptions
    let color: String
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, type: LabelTypeOptions, text: String, color: String) {
        self.type = type
        self.color = color
        
        super.init(frame: frame)
        
        setup(text: text)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setup(text: String) {
        applyStyle()
        applyContent(text)
    }
    
    private func applyStyle() {
        switch type {
        case .title:
            self.font = UIFont(name: "Poppins-Medium", size: 20)
        case .text:
            self.font = UIFont(name: "Inter-Regular", size: 14)
        case .microText:
            self.font = UIFont(name: "Inter-Regular", size: 12)
        case .cardTitle:
            self.font = UIFont(name: "Poppins-Regular", size: 14)
        case .cardText:
            self.font = UIFont(name: "Inter-Regular", size: 11)
        case .labelInput:
            self.font = UIFont(name: "Inter-Regular", size: 14)
        case .divider:
            self.font = UIFont(name: "Poppins-Regular", size: 16)
        case .logo:
            self.font = UIFont(name: "Nunito-SemiBold", size: 26)
        case .empty:
            self.font = UIFont(name: "Nunito-SemiBold", size: 20)
        case .select:
            self.font = UIFont(name: "Inter-Regular", size: 16)
        }
        self.textColor = UIColor(named: color)
    }
    
    private func applyContent(_ text: String) {
        self.text = text
    }
}

extension CoreLabel: CoreLabelType {
    
}
