//
//  CoreDividerLabel.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 07/08/21.
//
//

import UIKit

final class CoreDividerLabel: UIStackView {
    
    // MARK: - PARAMS
    
    let text: String
    let iconName: String
    
    // MARK: - UI
    
    private lazy var iconView: UIImageView = {
        let icon = UIImageView(image: UIImage(named: iconName))
        
        icon.tintColor = UIColor(named: "NeonBlackColor")
        
        return icon
    }()
    
    private lazy var labelView: CoreLabel = {
        let label = CoreLabel(type: .divider, text: text, color: "NeonBlackColor")
        
        return label
    }()
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, text: String, iconName: String) {
        self.text = text
        self.iconName = iconName
        
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setup() {
        buildHierarchy()
        buildStyle()
    }
    
    private func buildHierarchy() {
        self.addArrangedSubview(iconView)
        self.addArrangedSubview(labelView)
    }
    
    private func buildStyle() {
        self.axis = .horizontal
        self.alignment = .leading
        self.spacing = 8
    }
}
