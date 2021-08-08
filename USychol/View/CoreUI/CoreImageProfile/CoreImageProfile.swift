//
//  CoreImageProfile.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 07/08/21.
//
//

import UIKit

final class CoreImageProfile: UIStackView {
    
    // MARK: - PARAMS
    
    let profileURL: String
    
    // MARK: - UI
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        
        image.load(url: URL(string: profileURL)!)
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor(named: "PurpleStrongLightColor")?.cgColor
        
        return image
    }()
    
    private lazy var dividerView: UIView = {
        let divider = UIView()
        
        divider.backgroundColor = UIColor(named: "MainPurpleColor")
        divider.layer.cornerRadius = 1
        
        return divider
    }()
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, profileURL: String) {
        self.profileURL = profileURL
        
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
        addConstraints()
    }
    
    private func buildHierarchy() {
        self.addArrangedSubview(profileImageView)
        self.addArrangedSubview(dividerView)
    }
    
    private func buildStyle() {
        self.axis = .vertical
        self.alignment = .center
        self.spacing = 30
    }
    
    private func addConstraints() {
        profileImageView.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        dividerView.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(2)
            make.width.equalTo(50)
        }
    }
}
