//
//  PatientTableViewCell.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 05/08/21.
//

import UIKit

final class PatientTableViewCell: UITableViewCell {
    
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
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor(named: "NeonBlackColor")?.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5
        
        return view
    }()
    
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
        label.textColor = UIColor(named: "MainPurpleColor")
        
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Inter-Regular", size: 11)
        label.textColor =  UIColor(named: "PurpleLightColor")
        
        return label
    }()
    
    let appointmentLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "Inter-Regular", size: 11)
        label.textColor =  UIColor(named: "PurpleLightColor")
        
        return label
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
        self.backgroundColor = UIColor(named: "WhiteColor")
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(named: "WhiteColor")
        self.selectedBackgroundView = bgColorView
    }
    
    private func buildViewHierarchy(containerStackView: UIStackView) {
        containerView.addSubview(containerStackView)
        addSubview(containerView)
    }
    
    private func addConstraints(containerStackView: UIStackView) {
        containerView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(self).offset(10)
            make.leading.equalTo(self).offset(16)
            make.trailing.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(10)
        }
        
        containerStackView.snp.makeConstraints {(make) -> Void in
            make.centerY.equalTo(containerView)
            make.leading.equalTo(containerView).offset(8)
            make.trailing.equalTo(containerView).inset(8)
        }
    }
    
    // MARK: - DATASET
    
    var patients: Patient? {
        didSet {
            guard let patientItem = patients else {return}
            let labelStackView = createLabelStackView([titleLabel, ageLabel, appointmentLabel])
            let containerStackView = createContainerStackView([profileImageView, labelStackView])
                
            buildViewHierarchy(containerStackView: containerStackView)
            addConstraints(containerStackView: containerStackView)
                
            profileImageView.load(url: URL(string: patientItem.profilePicture)!)
            
            titleLabel.text = patientItem.name
            
            ageLabel.text = "Age: \(patientItem.age) years"
            appointmentLabel.text = "\(patientItem.appointmentCount)x appointments - month"
        }
    }
}

