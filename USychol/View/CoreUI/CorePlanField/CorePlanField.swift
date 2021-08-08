//
//  CorePlanField.swift
//  USychol
//
//  Created by Fernando Rodrigues on 07/08/21.
//

import UIKit

final public class CorePlanField: UIView  {
    // MARK: - PARAMS

    let text: String
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero, text: String){
        self.text = text
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var checkMarkIcon: UIImageView = {
        let image = UIImage(named: "accept-icon")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private lazy var benefitLabel: CoreLabel =
        CoreLabel(
            type: .text,
            text: "Use interactive digital resources created or purchased with the patient whenever you want and have access to Psycho Dash 24h",
            color: "WhiteColor"
        )
    
    // MARK: - PRIVATE
    
    private func setup(){
        applyContent()
        buildHierarchy()
        buildConstraints()
    }
    
    private func applyContent(){
        benefitLabel.text = text
    }
    
    private func buildHierarchy(){
        self.addSubview(checkMarkIcon)
        self.addSubview(benefitLabel)
    }
    
    private func buildConstraints(){
        checkMarkIcon.snp.makeConstraints{(make) -> Void in
            make.top.equalToSuperview()
        }
        
        benefitLabel.snp.makeConstraints{(make) -> Void in
            benefitLabel.numberOfLines = 3
            make.width.equalTo(360)
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 4, left: 32, bottom: 0, right: 0))
        }
    }
}
