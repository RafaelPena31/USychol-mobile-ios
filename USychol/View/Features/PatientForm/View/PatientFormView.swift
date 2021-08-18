//
//  PatientFormView.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 06/08/21.
//
//

import UIKit
import SnapKit

final public class PatientFormView: UIView {
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var coreImageProfile: CoreImageProfile = {
        let image = CoreImageProfile(profileURL: "https://mk0anatomieunes58h83.kinstacdn.com/wp-content/themes/cera/assets/images/avatars/user-avatar.png")
        
        return image
    }()
    
    private lazy var patientFormStack: PatientFormStack = {
        let form = PatientFormStack()

        return form
    }()
    
    private lazy var createButtom: CoreButton = {
        let button = CoreButton(type: .normal, title: "Create", onPressMethod: onPressCreate)
        
        return button
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
    
    // MARK: - PRIVATE METHODS
    
    func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(coreImageProfile)
        contentView.addSubview(patientFormStack)
        contentView.addSubview(createButtom)
        
        scrollView.addSubview(contentView)
        
        containerView.addSubview(scrollView)
        
        self.addSubview(containerView)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints {(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        scrollView.snp.makeConstraints {(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.width.equalTo(containerView)
            make.height.equalTo(containerView).priority(.low)
        }
        
        coreImageProfile.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(contentView)
            make.centerX.equalTo(contentView)
        }
        
        patientFormStack.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(coreImageProfile.snp.bottom).offset(24)
            make.leading.equalTo(containerView).inset(16)
            make.trailing.equalTo(containerView).inset(16)
        }
        
        createButtom.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(patientFormStack.snp.bottom).offset(32)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(55)
            make.bottomMargin.equalTo(scrollView).inset(24)
        }
    }
    
    private func updateView(with entity: PatientFormViewEntity) {
        
    }
    
    // MARK: - ACTIONS
    private func onPressCreate() {
        let userID = UserDefaults.standard.getUserID()
        let newPatient = Patient(id: UUID().uuidString,
                                 name: patientFormStack.nameTextField.text,
                                 patientSummary: patientFormStack.summaryTextField.text,
                                 age: patientFormStack.ageTextField.text,
                                 patientClass: patientFormStack.patientClassTextField.text,
                                 motherName: patientFormStack.motherTextField.text,
                                 fatherName: patientFormStack.fatherTextField.text,
                                 maritalStatus: patientFormStack.maritalTextField.text,
                                 appointmentCount: Int(patientFormStack.appointmentCountTextField.text) ?? 1,
                                 reports: [],
                                 fromUser: userID)
        
        delegate?.onHandleCreatePatient(patient: newPatient)
    }
}

extension PatientFormView: PatientFormViewType {
    public func updateView(with viewState: PatientFormViewState) {

    }
}
