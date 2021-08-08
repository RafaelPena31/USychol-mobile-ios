//
//  VirtualPlanView.swift
//  USychol
//
//  Created Fernando Rodrigues on 06/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final public class VirtualPlanView: UIView {
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let gradientStyle = GradientStyle(bounds: UIScreen.main.bounds, color: .yellow, parentLayer: view)
        gradientStyle.setGradient()
        
        return view
    }()
    
    private lazy var contentView: UIView = {
       let view = UIView()
       return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        return view
    }()
    
    private lazy var title: CoreLabel = CoreLabel(type: .text, text: "Choose your plan", color: "WhiteColor")
    private lazy var headerView: UIView = {
       let view = UIView()
       return view
    }()
    
    private lazy var price: CoreLabel = CoreLabel(type: .logo, text: "$49,90", color: "WhiteColor")
    private lazy var priceLabel: CoreLabel = CoreLabel(type: .text, text: "/month", color: "WhiteColor")
    private lazy var planTitle: CoreLabel = CoreLabel(type: .logo, text: "Virtual Manager", color: "WhiteColor")
    private lazy var planDesc: CoreLabel =
        CoreLabel(
            type: .text,
            text: "Use interactive digital resources created or purchased with the patient whenever you want and have access to Psycho Dash 24h",
            color: "WhiteColor"
        )
    
    private lazy var horizontalLine: UIView = {
       let view = UIView()
        view.backgroundColor = .white
       return view
    }()
    
    private lazy var benefitViewOne: CorePlanField = CorePlanField(text: "End to end security")
    private lazy var benefitViewTwo: CorePlanField = CorePlanField(text: "Create and purchase interactive digital assets whenever you want, with low latency and high perfomance")
    private lazy var benefitViewThree: CorePlanField = CorePlanField(text: "Create up to 15 patient profiles")
    private lazy var benefitViewFour: CorePlanField = CorePlanField(text: "Access to Psycho Dash")
    
    private lazy var button: CoreButton = CoreButton(type: .light, title: "Start now", onPressMethod: onHandleClick)
    
    private lazy var pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.tintColor = .blue
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.backgroundStyle = .minimal
        pageControl.addTarget(self, action: #selector(handleTouch), for: .touchDown)
       return pageControl
    }()
    
    // MARK: - PUBLIC API

    public weak var delegate: VirtualPlanViewDelegate?
    
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
        contentView.addSubview(title)
        
        headerView.addSubview(price)
        headerView.addSubview(priceLabel)
        
        contentView.addSubview(headerView)
        contentView.addSubview(planTitle)
        contentView.addSubview(planDesc)
        
        
        contentView.addSubview(horizontalLine)
        contentView.addSubview(benefitViewOne)
        contentView.addSubview(benefitViewTwo)
        contentView.addSubview(benefitViewThree)
        contentView.addSubview(benefitViewFour)
        contentView.addSubview(benefitViewFour)
        contentView.addSubview(button)
        contentView.addSubview(pageControl)
        
        scrollView.addSubview(contentView)
        containerView.addSubview(scrollView)
        
        addSubview(containerView)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        title.snp.makeConstraints{(make) -> Void in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset((UIScreen.main.bounds.width / 2) - (title.intrinsicContentSize.width / 2))
        }
        
        headerView.snp.makeConstraints{(make) -> Void in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().inset(32)
            make.right.equalToSuperview()
        }
        
        price.snp.makeConstraints{(make) -> Void in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints{(make) -> Void in
            make.right.equalToSuperview().inset(64)
            make.top.equalToSuperview().inset(16)
        }
        
        planTitle.snp.makeConstraints{(make) -> Void in
            make.edges.equalTo(headerView).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        planDesc.snp.makeConstraints{(make) -> Void in
            planDesc.numberOfLines = 3
            make.edges.equalTo(planTitle).inset(UIEdgeInsets(top: 96, left: 0, bottom: 0, right: 16))
        }
        
        horizontalLine.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(planDesc).inset(80)
            make.left.equalToSuperview().inset(32)
            make.width.equalTo(360)
            make.height.equalTo(1)
        }
        
        benefitViewOne.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(horizontalLine).inset(24)
            make.left.equalTo(horizontalLine)
        }
        
        benefitViewTwo.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(benefitViewOne).inset(48)
            make.left.equalTo(benefitViewOne)
        }
        
        benefitViewThree.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(benefitViewTwo).inset(64)
            make.left.equalTo(benefitViewTwo)
        }
        
        benefitViewFour.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(benefitViewThree).inset(48)
            make.left.equalTo(benefitViewThree)
        }
        
        button.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(55)
            make.bottom.equalTo(scrollView).inset(224)
            make.right.equalTo(self.containerView.safeAreaLayoutGuide).inset(16)
            make.left.equalTo(self.containerView.safeAreaLayoutGuide).offset(16)
        }
        
        pageControl.snp.makeConstraints{(make) -> Void in
            make.bottom.equalToSuperview().inset(336)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
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

    }
    
    private func updateView(with entity: VirtualPlanViewEntity) {
        delegate?.onHandleTouch()
    }
    
    private func onHandleClick(){
        delegate?.onHandleClick()
    }
    
    @objc func handleTouch(){
        delegate?.onHandleTouch()
    }

}
extension VirtualPlanView: VirtualPlanViewType {
    public func updateView(with viewState: VirtualPlanViewState) {
        
    }
}
