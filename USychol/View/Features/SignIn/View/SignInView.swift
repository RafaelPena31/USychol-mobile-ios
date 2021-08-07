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
    
    private lazy var emailInput: UIView = CoreInputField(placeholder: "Email", labelText: "Email")
    
    private lazy var passwordInput: UIView = CoreInputField(placeholder: "Password", labelText: "Password")
    
    private lazy var button: CoreButton = {
        let button = CoreButton(type: .normal, title: "Start now", onPressMethod: onHandleClick)
        
        return button
    }()
    
    private lazy var label: CoreLabel = CoreLabel(type: .labelInput, text: "Create new account", color: "NeonStrongLightColor")
    
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
        containerView.addSubview(emailInput)
        containerView.addSubview(passwordInput)
        addSubview(containerView)
        addSubview(label)
        addSubview(button)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints {(make) -> Void in
            make.edges.equalToSuperview()
        }
        emailInput.snp.makeConstraints{(make) -> Void in
            make.top.equalToSuperview().offset(64)
        }
        
        passwordInput.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(emailInput).inset(UIEdgeInsets(top: 256, left: 0, bottom: 0, right: 0))
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
    
    private func updateView(with entity: SignInViewEntity) {
        
    }
    
    // MARK: - ACTIONS
    
    func onHandleClick () {
        delegate?.onHandleClick()
    }
}

extension SignInView: SignInViewType {
    public func updateView(with viewState: SignInViewState) {
        
    }
}
