//
//  NewReportView.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final public class NewReportView: UIView {
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var reportNameInput: CoreInputField = CoreInputField(placeholder: "Thoughts of the day", labelText: "Activity Name")
    private lazy var resumeInput: CoreInputField = CoreInputField(placeholder: "Today...", labelText: "Resume", height: 220)
    private lazy var consultationInput: CoreInputField = CoreInputField(placeholder: "Rank from 0 - 10", labelText: "Consultation Evaluation")
    private lazy var reportInput: CoreInputField = CoreInputField(placeholder: "Januart 01 2021", labelText: "Report's day")
    
    private lazy var formStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [reportNameInput, resumeInput, consultationInput, reportInput])
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 16
       return stack
    }()
    
    private lazy var button: CoreButton = CoreButton(type: .normal, title: "Create", onPressMethod: onHandleClick)
    
    // MARK: - PUBLIC API

    public weak var delegate: NewReportViewDelegate?
    
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
        
        reportNameInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        resumeInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        consultationInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        reportInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        button.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(containerView).inset(36)
            make.height.equalTo(55)
            make.right.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.left.equalTo(self.containerView.safeAreaLayoutGuide).offset(16)
        }
    }
    
    private func updateView(with entity: NewReportViewEntity) {
        
    }
    
    func onHandleClick(){
        
    }
}

extension NewReportView: NewReportViewType {
    public func updateView(with viewState: NewReportViewState) {
        
    }
}
