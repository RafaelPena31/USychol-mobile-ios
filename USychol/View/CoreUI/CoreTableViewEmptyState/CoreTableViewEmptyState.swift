//
//  CoreTableViewEmptyState.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 14/08/21.
//

import UIKit

final class CoreTableViewEmptyState: UIView {
    
    // MARK: - PARAMS
    
    let imageName: String
    let labelProps: (text: String, color: String)
    
    // MARK: - UI
    
    private lazy var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: imageName))
        return image
    }()
    
    private lazy var label: CoreLabel = {
        let label = CoreLabel(type: .empty, text: labelProps.text, color: labelProps.color)
        
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, imageName: String, labelProps: (text: String, color: String)) {
        self.imageName = imageName
        self.labelProps = labelProps
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        buildHierarchy()
        addConstraints()
    }
    
    private func buildHierarchy() {
        self.addSubview(image)
        self.addSubview(label)
    }
    
    private func addConstraints() {
        image.snp.makeConstraints{(make) -> Void in
            make.center.equalTo(self)
        }
        
        label.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(image.snp.bottom).offset(16)
            make.centerX.equalTo(self)
            make.width.equalTo(250)
        }
    }
}
