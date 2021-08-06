//
//  PatientFormView.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 06/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final public class PatientFormView: UIView {
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - PUBLIC API

    public weak var delegate: PatientFormViewDelegate?
    
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
        addSubview(view)
    }
    
    private func addConstraints() {
        view.constraintToSuperview()
    }
    
    private func updateView(with entity: PatientFormViewEntity) {
        
    }
}

extension PatientFormView: PatientFormViewType {
    public func updateView(with viewState: PatientFormViewState) {
        
    }
}
