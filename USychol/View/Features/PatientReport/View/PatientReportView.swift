//
//  PatientReportView.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final public class PatientReportView: UIView {
    
    var reportData: Report?
    var mockResume = "Patient told of a dream that intrigued him about a dismal Quidditch game. He described feeling very scared of being knocked out by a Slytherin student"
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var topRoundBarView: UIView = {
        let topRoundBarView = UIView()
        
        topRoundBarView.backgroundColor = UIColor(named: "MainPurpleColor")
        
        topRoundBarView.clipsToBounds = true
        topRoundBarView.layer.cornerRadius = 10
        topRoundBarView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        return topRoundBarView
    }()
    
    private lazy var coreImageProfile: CoreImageProfile = {
        let image = CoreImageProfile(profileURL: "https://mk0anatomieunes58h83.kinstacdn.com/wp-content/themes/cera/assets/images/avatars/user-avatar.png")
        
        return image
    }()
    
    private lazy var dateLabel: CoreLabel = {
        let label = CoreLabel(type: .divider, text: reportData?.date ?? "xx/xx/xxxx", color: "NeonStrongLightColor")
        
        return label
    }()
    
    private lazy var performedActivitiesDividerLabel: CoreDividerLabel = {
        let label = CoreDividerLabel(text: "Performed activities", iconName: "profile-icon")
        
        return label
    }()
    
    private lazy var cardActivy: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "GreyLightColor")
        button.layer.cornerRadius = 8
        
        button.setImage(UIImage(named: "image-icon"), for: .normal)
        button.tintColor = UIColor(named: "NeonLightBlackColor")
        
        return button
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "MainPurpleColor")
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    private lazy var resumeDividerLabel: CoreDividerLabel = {
        let label = CoreDividerLabel(text: "Resume", iconName: "paper-icon")
        
        return label
    }()
    
    private lazy var resumeText: CoreLabel = {
        let label = CoreLabel(type: .cardTitle, text: reportData?.resume ?? mockResume, color: "NeonStrongLightColor")
        
        label.numberOfLines = 0
        label.textAlignment = .justified
        
        return label
    }()
    
    private lazy var patientResumeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [resumeDividerLabel, resumeText])
        
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 16
        
        return stack
    }()
    
    // MARK: - PUBLIC API

    public weak var delegate: PatientReportViewDelegate?
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(coreImageProfile)
        contentView.addSubview(dateLabel)
        
        contentView.addSubview(performedActivitiesDividerLabel)
        contentView.addSubview(cardActivy)
        contentView.addSubview(dividerView)
        
        contentView.addSubview(patientResumeStack)
        
        scrollView.addSubview(contentView)
        
        containerView.addSubview(topRoundBarView)
        containerView.addSubview(scrollView)
        
        addSubview(containerView)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints {(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        topRoundBarView.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(20)
            make.leading.equalTo(containerView)
            make.trailing.equalTo(containerView)
            make.top.equalTo(containerView)
        }
        
        scrollView.snp.makeConstraints {(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(topRoundBarView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.width.equalTo(containerView)
            make.height.equalTo(containerView).priority(.low)
        }
        
        coreImageProfile.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(contentView).offset(40)
            make.centerX.equalTo(contentView)
        }
        
        dateLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(coreImageProfile.snp.bottom).offset(16)
            make.centerX.equalTo(containerView)
        }
        
        performedActivitiesDividerLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(dateLabel.snp.bottom).offset(40)
            make.leading.equalTo(contentView).offset(16)
        }
        
        cardActivy.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(performedActivitiesDividerLabel.snp.bottom).offset(16)
            make.height.equalTo(120)
            make.width.equalTo(200)
            make.centerX.equalTo(containerView)
        }
        
        dividerView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(cardActivy.snp.bottom).offset(24)
            make.centerX.equalTo(containerView)
            make.width.equalTo(48)
            make.height.equalTo(2)
        }
        
        patientResumeStack.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(dividerView).offset(80)
            make.leading.equalTo(contentView).inset(16)
            make.trailing.equalTo(16).inset(16)
        }
    }
    
    private func updateView(with entity: PatientReportViewEntity) {
        
    }
}

extension PatientReportView: PatientReportViewType {
    public func updateView(with viewState: PatientReportViewState) {
        switch viewState {
        case .hasData(let entity):
            reportData = entity.report
        default: break
        }
    }
}
