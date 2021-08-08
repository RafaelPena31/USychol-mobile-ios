//
//  ReportTableViewCell.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//

import UIKit

final class ReportTableViewCell: UITableViewCell {
    
    // MARK: - INITIALIZERS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    let profileImageView: UIImageView = {
       let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 21
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor(named: "PurpleStrongLightColor")?.cgColor
        
        image.snp.makeConstraints {(make) -> Void in
            make.width.equalTo(42)
            make.height.equalTo(42)
        }
        
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.textColor = UIColor(named: "WhiteColor")
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Inter-Regular", size: 11)
        label.textColor =  UIColor(named: "ParcialWhiteColor")
        
        return label
    }()
    
    let separatorView: UIView = {
        let separator = UIView()
        
        separator.backgroundColor = UIColor(named: "StrongParcialWhiteColor")
        
        return separator
    }()
    
    // MARK: - UI PRIVATE METHODS
    
    private func createLabelStackView(_ arrangedSubviews: [UIView]) -> UIStackView {
        let labelStackView = UIStackView(arrangedSubviews: arrangedSubviews)
        
        labelStackView.alignment = .leading
        labelStackView.spacing = 0
        labelStackView.axis = .vertical
        
        return labelStackView
    }
    
    private func createContainerStackView(_ arrangedSubviews: [UIView]) -> UIStackView {
        let containerStackView = UIStackView(arrangedSubviews: arrangedSubviews)
        
        containerStackView.alignment = .center
        containerStackView.spacing = 12
        containerStackView.axis = .horizontal
        
        return containerStackView
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setup() {
        buildStyle()
    }
    
    private func buildStyle() {
        self.backgroundColor = UIColor(named: "MainPurpleColor")
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(named: "DarkPurpleColor")
        self.selectedBackgroundView = bgColorView
    }
    
    private func buildViewHierarchy(containerStackView: UIStackView) {
        addSubview(containerStackView)
        addSubview(separatorView)
    }
    
    private func addConstraints(containerStackView: UIStackView) {
        containerStackView.snp.makeConstraints {(make) -> Void in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).inset(16)
        }
        
        separatorView.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(1)
            make.bottom.equalTo(containerStackView).offset(12)
            make.leading.equalTo(containerStackView)
            make.trailing.equalTo(containerStackView)
        }
    }
    
    // MARK: - DATASET
    
    var patientProfilePic: String?
    
    var reports: Report? {
        didSet {
            let labelStackView = createLabelStackView([titleLabel, descriptionLabel])
            
            guard let reportItem = reports else {return}
            
            let containerStackView = createContainerStackView([profileImageView, labelStackView])
                
            buildViewHierarchy(containerStackView: containerStackView)
            addConstraints(containerStackView: containerStackView)
            
            profileImageView.load(url: URL(string: patientProfilePic!)!)
            titleLabel.text = "\(reportItem.date) - \(reportItem.startAt)"
            descriptionLabel.text = "Query report"
        }
    }
}
