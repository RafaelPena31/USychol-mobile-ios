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
    
    public func updateState() {
        let reportRepository = ReportRepository()
        let patientRepository = PatientRepository()
        
        let currentPatientInfo = patientRepository.getCurrentPatient()!
        let reports = reportRepository.getReports(patientId: currentPatientInfo.id)
        
        viewState = .hasData(PatientProfileViewEntity(reportsData: reports, patient: currentPatientInfo))
    }
}

extension PatientProfileViewModel: PatientProfileViewControllerDelegate {
    public func setCurrentReport(report: Report) -> Bool {
        let reportRepository = ReportRepository()
        let updateState = reportRepository.setCurrentReport(report: report)
        
        return updateState
    }
}
