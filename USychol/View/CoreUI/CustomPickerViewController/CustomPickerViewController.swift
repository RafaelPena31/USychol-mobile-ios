//
//  CustomPickerViewController.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 14/08/21.
//

import UIKit

class CustomPickerViewController: UIViewController {
    // MARK: - PARAMS
    
    let onHandleSelect: ((_ type: PatientClass) -> Void)?
    
    // MARK: - UI
    
    let maxDimmedAlpha: CGFloat = 0.6
    let defaultHeight: CGFloat = 300
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var backdropView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        
        return view
    }()
    
    private lazy var dividerView: UIView = {
        let divider = UIView()
        
        divider.backgroundColor = UIColor(named: "GreyPlaceholderColor")
        divider.layer.cornerRadius = 2
        
        return divider
    }()
    
    private lazy var selectLabel: CoreLabel = {
        let label = CoreLabel(type: .select, text: "Select", color: "NeonBlackColor")
        
        return label
    }()
    
    private lazy var childButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "GreyLightColor")
        button.layer.cornerRadius = 8
        
        button.setTitle("Child", for: .normal)
        button.setTitleColor(UIColor(named: "NeonBlackColor"), for: .normal)
        
        button.addTarget(self, action: #selector(onHandleSelectChild), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var teenButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "GreyLightColor")
        button.layer.cornerRadius = 8
        
        button.setTitle("Teen", for: .normal)
        button.setTitleColor(UIColor(named: "NeonBlackColor"), for: .normal)
        
        button.addTarget(self, action: #selector(onHandleSelectTeen), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var adultButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "GreyLightColor")
        button.layer.cornerRadius = 8
        
        button.setTitle("Adult", for: .normal)
        button.setTitleColor(UIColor(named: "NeonBlackColor"), for: .normal)
        
        button.addTarget(self, action: #selector(onHandleSelectAdult), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var selectButtonGroup: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [childButton, teenButton, adultButton])
        
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        
        return stack
    }()
    
    // MARK: - INITIALIZERS
    
    public init(onHandleSelect: ((_ type: PatientClass) -> Void)?) {
        self.onHandleSelect = onHandleSelect
        
        super.init(nibName: nil, bundle: nil)
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animateDismissView))
        backdropView.addGestureRecognizer(tapGesture)
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateShowBackdropView()
        animatePresentContainer()
    }
    
    // MARK: - PRIVATES
    
    private func setup() {
        buildHierarchy()
        addConstraints()
        buildStyle()
    }
        
    private func buildStyle() {
        view.backgroundColor = .clear
    }
    
    private func buildHierarchy() {
        contentView.addSubview(dividerView)
        contentView.addSubview(selectLabel)
        contentView.addSubview(selectButtonGroup)
        
        scrollView.addSubview(contentView)
        containerView.addSubview(scrollView)
        
        view.addSubview(backdropView)
        view.addSubview(containerView)
    }
        
    private func addConstraints() {
        backdropView.snp.makeConstraints{(make) -> Void in
            make.top.bottom.leading.trailing.equalTo(view)
        }
        
        containerView.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(view)
            make.height.equalTo(defaultHeight)
            make.bottom.equalTo(defaultHeight)
        }
        
        scrollView.snp.makeConstraints {(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(containerView)
            make.bottom.equalTo(containerView)
        }
        
        contentView.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(0)
            make.top.equalTo(containerView)
        }
        
        dividerView.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(3)
            make.width.equalTo(50)
            make.top.equalTo(containerView).offset(8)
            make.centerX.equalTo(containerView)
        }
        
        selectLabel.snp.makeConstraints{(make) -> Void in
            make.centerX.equalTo(containerView)
            make.top.equalTo(dividerView.snp.bottom).offset(10)
        }
        
        childButton.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(55)
            make.leading.trailing.equalTo(0)
        }
        
        teenButton.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(55)
            make.leading.trailing.equalTo(0)
        }
        
        adultButton.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(55)
            make.leading.trailing.equalTo(0)
        }
        
        selectButtonGroup.snp.makeConstraints{(make) -> Void in
            make.trailing.equalTo(containerView).inset(16)
            make.leading.equalTo(containerView).inset(16)
            make.top.equalTo(selectLabel.snp.bottom).offset(32)
        }
    }
    
    private func animateShowBackdropView() {
        backdropView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.backdropView.alpha = self.maxDimmedAlpha
        }
    }
    
    private func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerView.snp.makeConstraints{(make) -> Void in
                make.bottom.equalTo(0)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - ACTIONS
    
    @objc private func animateDismissView() {
        backdropView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.1) {
            self.backdropView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    @objc private func onHandleSelectChild() {
        animateDismissView()
        onHandleSelect!(.child)
    }
    
    @objc private func onHandleSelectTeen() {
        animateDismissView()
        onHandleSelect!(.teen)
    }
    
    @objc private func onHandleSelectAdult() {
        animateDismissView()
        onHandleSelect!(.adult)
    }
}
