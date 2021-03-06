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
    
    
    private lazy var emailInput: CoreInputField = CoreInputField(placeholder: "Email", labelText: "Email")
    private lazy var nameInput: CoreInputField = CoreInputField(placeholder: "Name", labelText: "Name")
    private lazy var birthdayInput: CoreInputField = CoreInputField(placeholder: "January 01 2020", labelText: "Birthday")
    private lazy var registrationInput: CoreInputField = CoreInputField(placeholder: "00000", labelText: "CPR Registration Number")
    private lazy var documentInput: CoreInputField = CoreInputField(placeholder: "***-***-***.**", labelText: "ID Document")
    private lazy var passwordInput: CoreInputField = CoreInputField(placeholder: "********", labelText: "Password")
    
    private lazy var button: CoreButton = {
        let button = CoreButton(type: .normal, title: "Sign up", onPressMethod: onHandleClick)
        
        return button
    }()
    
    private lazy var label: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(onHandleChange), for: .touchUpInside)
        button.setTitle("Already have an account", for: .normal)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 12)
        return button
    }()
    
    private lazy var formStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [emailInput, nameInput, birthdayInput, registrationInput, documentInput, passwordInput])
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 16
       return stack
    }()
    
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
        contentView.addSubview(formStack)
        
        contentView.addSubview(label)
        contentView.addSubview(button)
        
        scrollView.addSubview(contentView)
        
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
        
        scrollView.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(scrollView)
            make.trailing.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(containerView).priority(.low)
        }
        
        formStack.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(80)
            make.leading.equalTo(containerView).inset(16)
            make.trailing.equalTo(containerView).inset(16)
        }
        
        nameInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        birthdayInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }

        registrationInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        emailInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
                
        documentInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        passwordInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }

        
        button.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(containerView).inset(36)
            make.height.equalTo(55)
            make.right.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.left.equalTo(self.containerView.safeAreaLayoutGuide).offset(16)
        }
        
        label.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(containerView).inset(96)
            make.right.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.left.equalTo(self.containerView.safeAreaLayoutGuide).offset(16)
        }
    }
    
    private func updateView(with entity: SignUpViewEntity) {
        
    }
    
    // MARK: - ACTIONS
    
    func onHandleClick () {
        let name = nameInput.text
        let email = emailInput.text
        let age = birthdayInput.text
        let crp = registrationInput.text
        let cpf = documentInput.text
        let password = passwordInput.text
        
        if name.isEmpty || email.isEmpty || age.isEmpty || crp.isEmpty || cpf.isEmpty || password.isEmpty {
            delegate?.onHandleFormAlert()
        } else {
            let userInfo = User(id: UUID().uuidString, name: name, email: email, age: age, crp: crp, cpf: cpf, plan: nil, password: password)
            delegate?.onHandleClick(user: userInfo)
        }
    }
    
    @objc func onHandleChange(){
        delegate?.onHandleChange()
    }
}


extension SignUpView: SignUpViewType {
    public func updateView(with viewState: SignUpViewState) {
        
    }
}
