//
//  PatientAnamnesisView.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final public class PatientAnamnesisView: UIView {
    // MARK: - PROPERTIES
    
    var patient = Patient(id: "", name: "", patientSummary: "", age: "", patientClass: "", motherName: "", fatherName: "", maritalStatus: "", appointmentCount: 1, reports: [], fromUser: "")
    var isEditable = false
    
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
    
    private lazy var topRoundBarView: UIView = {
        let topRoundBarView = UIView()
        
        topRoundBarView.backgroundColor = UIColor(named: "MainPurpleColor")
        
        topRoundBarView.clipsToBounds = true
        topRoundBarView.layer.cornerRadius = 10
        topRoundBarView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        return topRoundBarView
    }()
    
    private lazy var coreImageProfile: CoreImageProfile = {
        let image = CoreImageProfile(profileURL: "https://mk0anatomieunes58h83.kinstacdn.com/wp-content/themes/cera/assets/images/avatars/user-avatar.png")
        
        return image
    }()
    
    private lazy var anamnesisFormStack: AnamnesisFormStack = {
        let form = AnamnesisFormStack()

        return form
    }()
    
    private lazy var editAnamnesisButton: CoreRedirectButton = {
        let button = CoreRedirectButton(leftIconName: "list-icon", title: "Edit anamnesis", onPressMethod: onHandleEditAnamnesis)
        
        return button
    }()
    
    // MARK: - PUBLIC API

    public weak var delegate: PatientAnamnesisViewDelegate?
    
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
        contentView.addSubview(coreImageProfile)
        contentView.addSubview(anamnesisFormStack)
        contentView.addSubview(editAnamnesisButton)
        
        scrollView.addSubview(contentView)
        
        containerView.addSubview(topRoundBarView)
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
        
        topRoundBarView.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(20)
            make.leading.equalTo(containerView)
            make.trailing.equalTo(containerView)
            make.top.equalTo(containerView)
        }
        
        scrollView.snp.makeConstraints {(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(topRoundBarView.snp.bottom)
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
            make.top.equalTo(contentView).offset(40)
            make.centerX.equalTo(contentView)
        }
        
        anamnesisFormStack.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(coreImageProfile.snp.bottom).offset(24)
            make.leading.equalTo(containerView).inset(16)
            make.trailing.equalTo(containerView).inset(16)
        }
        
        editAnamnesisButton.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(anamnesisFormStack.snp.bottom).offset(32)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).inset(16)
            make.height.equalTo(55)
            make.bottomMargin.equalTo(scrollView).inset(24)
        }
    }
    
    private func updateView(with entity: PatientAnamnesisViewEntity) {
        
    }
    
    // MARK: - ACTIONS
    
    func onHandleReleaseEditInfo() {
        isEditable = !isEditable
        
        anamnesisFormStack.nameTextField.setIsEnable(isEditable)
        anamnesisFormStack.ageTextField.setIsEnable(isEditable)
        anamnesisFormStack.summaryTextField.setIsEnable(isEditable)
        anamnesisFormStack.patientClassTextField.setIsEnable(isEditable)
        anamnesisFormStack.motherTextField.setIsEnable(isEditable)
        anamnesisFormStack.fatherTextField.setIsEnable(isEditable)
        anamnesisFormStack.maritalTextField.setIsEnable(isEditable)
        anamnesisFormStack.appointmentCountTextField.setIsEnable(isEditable)
    }
    
    func updatePatientData() {
        let name = anamnesisFormStack.nameTextField.text.isEmpty ? patient.name : anamnesisFormStack.nameTextField.text
        let age = anamnesisFormStack.ageTextField.text.isEmpty ? patient.age : anamnesisFormStack.ageTextField.text
        let summary = anamnesisFormStack.summaryTextField.text.isEmpty ? patient.patientSummary : anamnesisFormStack.summaryTextField.text
        let patientClass =  anamnesisFormStack.patientClassTextField.text.isEmpty ? patient.patientClass : anamnesisFormStack.patientClassTextField.text
        let motherName = anamnesisFormStack.motherTextField.text.isEmpty ? patient.motherName : anamnesisFormStack.motherTextField.text
        let fatherName = anamnesisFormStack.fatherTextField.text.isEmpty ? patient.fatherName : anamnesisFormStack.fatherTextField.text
        let maritalStatus = anamnesisFormStack.maritalTextField.text.isEmpty ? patient.maritalStatus : anamnesisFormStack.maritalTextField.text
        let appointmentCount = anamnesisFormStack.appointmentCountTextField.text.isEmpty ? patient.appointmentCount : Int(anamnesisFormStack.appointmentCountTextField.text) ?? patient.appointmentCount
        
        
        
        let newPatient = Patient(id: patient.id,
                                 name: name,
                                 patientSummary: summary,
                                 age: age,
                                 patientClass: patientClass,
                                 motherName: motherName,
                                 fatherName: fatherName,
                                 maritalStatus: maritalStatus,
                                 appointmentCount: appointmentCount,
                                 reports: [],
                                 fromUser: patient.fromUser)
        
        patient = newPatient
        delegate?.handleFormAlert()
    }
    
    func updateInputs() {
        anamnesisFormStack.nameTextField.setText(patient.name)
        anamnesisFormStack.ageTextField.setText(patient.age)
        anamnesisFormStack.summaryTextField.setText(patient.patientSummary)
        anamnesisFormStack.patientClassTextField.setText(patient.patientClass)
        anamnesisFormStack.motherTextField.setText(patient.motherName)
        anamnesisFormStack.fatherTextField.setText(patient.fatherName ?? "")
        anamnesisFormStack.maritalTextField.setText(patient.maritalStatus)
        anamnesisFormStack.appointmentCountTextField.setText(String(patient.appointmentCount))
    }
    
    func onHandleEditAnamnesis() {
        if isEditable {
            updatePatientData()
            onHandleReleaseEditInfo()
            delegate?.onHandleUpdatePatient(patient: patient)
            updateInputs()
            editAnamnesisButton.setTitle("Edit Anamnesis", for: .normal)
        } else {
            onHandleReleaseEditInfo()
            editAnamnesisButton.setTitle("Save Anamnesis", for: .normal)
        }
    }
}

extension PatientAnamnesisView: PatientAnamnesisViewType {
    public func updateView(with viewState: PatientAnamnesisViewState) {
        switch viewState {
        case .hasData(let entity):
            self.patient = entity.patient
            updateInputs()
        default:
            break
        }
    }
}
