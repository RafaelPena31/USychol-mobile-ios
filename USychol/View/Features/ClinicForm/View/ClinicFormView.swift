//
//  ClinicFormView.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 07/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final public class ClinicFormView: UIView {
    
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
    
    private lazy var clinicFormStack: ClinicFormStack = {
        let stack = ClinicFormStack()
        
        return stack
    }()
    
    private lazy var editInformationButton: CoreRedirectButton = {
        let button = CoreRedirectButton(leftIconName: "list-icon", title: "Edit profile information", onPressMethod: onHandleEditInfo)
        
        return button
    }()
    
    // MARK: - PUBLIC API

    public weak var delegate: ClinicFormViewDelegate?
    
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
        contentView.addSubview(clinicFormStack)
        contentView.addSubview(editInformationButton)
        
        scrollView.addSubview(contentView)
        
        containerView.addSubview(topRoundBarView)
        containerView.addSubview(scrollView)
        
        self.addSubview(containerView)
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
        
        clinicFormStack.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(coreImageProfile.snp.bottom).offset(24)
            make.trailing.equalTo(containerView).inset(16)
            make.leading.equalTo(containerView).inset(16)
        }
        
        editInformationButton.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(clinicFormStack.snp.bottom).offset(32)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(55)
            make.bottomMargin.equalTo(scrollView).inset(24)
        }
    }
    
    private func updateView(with entity: ClinicFormViewEntity) {
        
    }
    
    // MARK: - ACTIONS
    
    func onHandleEditInfo() {
        delegate?.onHandleEditInfo()
    }
}

extension ClinicFormView: ClinicFormViewType {
    public func updateView(with viewState: ClinicFormViewState) {
        
    }
}
