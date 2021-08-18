//
//  PatientProfileViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class PatientProfileViewModel: PatientProfileViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: PatientProfileViewControllerType?
    public var viewEntity: PatientProfileViewEntity?
    public var viewState: PatientProfileViewState = .isEmpty {
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
    
    // MARK: - PRIVATE METHODS
    
    private func updateState() {
        let reportRepository = ReportRepository()
        let reports = reportRepository.getReports(patientId: "0")
        
        let patientRepository = PatientRepository()
        if let patient = patientRepository.getPatientById(patientId: "0") {
            viewState = .hasData(PatientProfileViewEntity(reportsData: reports, patient: patient))
        }
    }
}
