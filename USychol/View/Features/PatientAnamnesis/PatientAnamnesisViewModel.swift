//
//  PatientAnamnesisViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class PatientAnamnesisViewModel: PatientAnamnesisViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: PatientAnamnesisViewControllerType?
    public var viewEntity: PatientAnamnesisViewEntity?
    public var viewState: PatientAnamnesisViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }
    
    // MARK: - INITIALIZERS

    public init() {

    }
    
    // MARK: - PUBLIC API

    public func initState() {
        updateState()
    }
    
    // MARK: - PRIVATES
    
    private func updateState() {
        let patientRepository = PatientRepository()
        if let patient = patientRepository.getCurrentPatient() {
            viewState = .hasData(PatientAnamnesisViewEntity(patient: patient))
        }
    }
}

extension PatientAnamnesisViewModel: PatientAnamnesisViewControllerDelegate {
    public func onHandleUpdatePatient(patient: Patient) -> Bool {
        let userRepository = UserRepository()
        let patientRepository = PatientRepository()
        if let currentUserInfo = userRepository.getUser() {
            
            var currentPatients = currentUserInfo.patient
            let currentPatientsInfoIndex = currentPatients.firstIndex(where: {$0.id == patient.id})!
            
            currentPatients.remove(at: currentPatientsInfoIndex)
            currentPatients.insert(patient, at: 0)
            
            let newUserInfo = EntityTree(userInfo: currentUserInfo.userInfo, patient: currentPatients, reminder: currentUserInfo.reminder)
            
            let updateState = userRepository.updateData(userInfo: newUserInfo)

            let patientUpdateState = patientRepository.setCurrentPatient(patient: patient)
            
            return updateState && patientUpdateState
        }
        return false
    }
}
