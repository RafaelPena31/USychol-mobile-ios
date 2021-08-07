//
//  SignUpView.swift
//  USychol
//
//  Created Fernando Rodrigues on 30/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final public class SignUpView: UIView {
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailInput: UIView = CoreInputField(placeholder: "Email", labelText: "Email")
    private lazy var nameInput: UIView = CoreInputField(placeholder: "Name", labelText: "Name")
    private lazy var birthdayInput: UIView = CoreInputField(placeholder: "January 01 2020", labelText: "Birthday")
    private lazy var registrationInput: UIView = CoreInputField(placeholder: "00000", labelText: "CPR Registration Number")
    private lazy var documentInput: UIView = CoreInputField(placeholder: "***-***-***.**", labelText: "ID Document")
    private lazy var passwordInput: UIView = CoreInputField(placeholder: "********", labelText: "Password")
    
    private lazy var button: CoreButton = {
        let button = CoreButton(type: .normal, title: "Sign up", onPressMethod: onHandleClick)
        
        return button
    }()
    
    private lazy var label: CoreLabel = CoreLabel(type: .labelInput, text: "I already have an account", color: "NeonStrongLightColor")
    
    // MARK: - PUBLIC API

    public weak var delegate: SignUpViewDelegate?
    
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
        contentView.addSubview(emailInput)
        contentView.addSubview(nameInput)
        contentView.addSubview(birthdayInput)
        contentView.addSubview(registrationInput)
        contentView.addSubview(documentInput)
        contentView.addSubview(passwordInput)
        scrollView.addSubview(contentView)
        containerView.addSubview(label)
        containerView.addSubview(button)
        containerView.addSubview(scrollView)
        addSubview(containerView)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints {(make) -> Void in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints{(make) -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        contentView.snp.makeConstraints{(make) -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        }
        
        nameInput.snp.makeConstraints{(make) -> Void in
            make.top.equalToSuperview().offset(-424)
        }
        
        birthdayInput.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(nameInput).inset(UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0))
        }

        registrationInput.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(birthdayInput).inset(UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0))
        }
        
        emailInput.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(registrationInput).inset(UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0))
        }
                
        documentInput.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(emailInput).inset(UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0))
        }
        
        passwordInput.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(documentInput).inset(UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0))
        }

        
        button.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(55)
            make.bottom.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.right.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.left.equalTo(self.containerView.safeAreaLayoutGuide).offset(16)
        }
        
        label.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(button).inset(UIEdgeInsets(top: -88, left: 0, bottom: 0, right: 0))
        }
    }
    
    private func updateView(with entity: SignUpViewEntity) {
        
    }
    
    func onHandleClick () {
        delegate?.onHandleClick()
    }
}


extension SignUpView: SignUpViewType {
    public func updateView(with viewState: SignUpViewState) {
        
    }
}
