//
//  SplashView.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 26/07/21.
//

import UIKit
import SnapKit

final public class SplashView: UIView {
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        let gradientStyle = GradientStyle(bounds: UIScreen.main.bounds, color: .purple, parentLayer: view)
        gradientStyle.setGradient()
        
        return view
    }()
    
    private lazy var emptyStateImage: UIImageView = {
        let image = UIImage(named: "empty-state")!
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    private lazy var button: CoreButton = {
        let button = CoreButton(type: .light, title: "Start now", onPressMethod: onHandleClick)
        
        return button
    }()
    
    // MARK: - PUBLIC API
    
    public weak var delegate: SplashViewDelegate?
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        containerView.addSubview(emptyStateImage)
        addSubview(containerView)
        addSubview(button)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        emptyStateImage.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }
        button.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(55)
            make.bottom.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.right.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.left.equalTo(self.containerView.safeAreaLayoutGuide).offset(16)
        }
    }
    
    // MARK: - ACTIONS
    
    func onHandleClick () {
        delegate?.onHandleClick()
    }
}

extension SplashView: SplashViewType {
}
