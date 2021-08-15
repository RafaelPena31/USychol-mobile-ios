//
//  SignInView.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 28/07/21.
//

import UIKit
import SnapKit

final public class SignInView: UIView {
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var emailInput: CoreInputField = CoreInputField(placeholder: "Email", labelText: "Email")
    
    private lazy var passwordInput: CoreInputField = CoreInputField(placeholder: "Password", labelText: "Password")
    
    private lazy var button: CoreButton = {
        let button = CoreButton(type: .normal, title: "Sign in", onPressMethod: signIn)
        
        return button
    }()
    
    private lazy var label: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(onHandleChange), for: .touchUpInside)
        button.setTitle("Create a new account", for: .normal)
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 12)
        return button
    }()
    
    private lazy var formStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [emailInput, passwordInput])
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 16
       return stack
    }()
    
    // MARK: - PUBLIC API

    public weak var delegate: SignInViewDelegate?
    
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
        
        addSubview(containerView)
        addSubview(label)
        addSubview(button)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints {(make) -> Void in
            make.edges.equalToSuperview()
        }
        
        formStack.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(156)
            make.leading.equalTo(containerView).inset(16)
            make.trailing.equalTo(containerView).inset(16)
        }
        
        emailInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        passwordInput.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
        }
        
        button.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(55)
            make.bottom.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.right.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.left.equalTo(self.containerView.safeAreaLayoutGuide).offset(16)
        }
        
        label.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(button).inset(64)
            make.leading.equalTo(containerView).inset(16)
            make.trailing.equalTo(containerView).inset(16)
        }
    }
    
    private func updateView(with entity: SignInViewEntity) {
        
    }
    
    // MARK: - ACTIONS
    
    @objc func signIn(){
        delegate?.signIn(
            email: emailInput.inputField.text ?? "",
            password: passwordInput.inputField.text ?? ""
        )
    }
    
    @objc func onHandleChange () {
        delegate?.onHandleChange()
    }

}

extension SignInView: SignInViewType {
    public func updateView(with viewState: SignInViewState) {
        switch viewState {
        case .isLogged(true):
            delegate?.onHandleClick()
            print("Opa")
        case .isLogged(false):
            print("Não foi")
        default:
            print("Não foi")
        }
    }
}
