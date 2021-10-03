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
    public func onHandleUpdatePatient(patient: Patient, onHandleUpdated:@escaping (Bool) -> Void) {
        let patientRepository = PatientRepository()
        patientRepository.updatePatient(patient: patient, completionRequest: onHandleUpdated)
    }
}
