//
//  NewActivityView.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final public class NewActivityView: UIView {
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var activityNameInput: CoreInputField = CoreInputField(placeholder: "Activity name", labelText: "Activity Name")
    private lazy var deliveryDayInput: CoreInputField = CoreInputField(placeholder: "January 01 2021", labelText: "Delivery Day")
    private lazy var descriptionInput: CoreInputField = CoreInputField(placeholder: "Today...", labelText: "Description")
    
    private lazy var button: CoreButton = CoreButton(type: .normal, title: "Create", onPressMethod: onHandleClick)
    
    private lazy var formStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [activityNameInput, deliveryDayInput, descriptionInput])
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 16
       return stack
    }()
    
    // MARK: - PUBLIC API

    public weak var delegate: NewActivityViewDelegate?
    
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
        containerView.addSubview(formStack)
        containerView.addSubview(button)
        addSubview(containerView)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        formStack.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(156)
            make.leading.equalTo(containerView).inset(16)
            make.trailing.equalTo(containerView).inset(16)
        }
        
        activityNameInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        deliveryDayInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        descriptionInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        button.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(containerView).inset(36)
            make.height.equalTo(55)
            make.right.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.left.equalTo(self.containerView.safeAreaLayoutGuide).offset(16)
        }
    }
    
    private func updateView(with entity: NewActivityViewEntity) {
        
    }
    
    func onHandleClick(){
        
    }
}

extension NewActivityView: NewActivityViewType {
    public func updateView(with viewState: NewActivityViewState) {
        
    }
}
