//
//  PatientReportViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class PatientReportViewModel: PatientReportViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: PatientReportViewControllerType?
    public var viewEntity: PatientReportViewEntity?
    public var viewState: PatientReportViewState = .isEmpty {
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
        let patientRepository = PatientRepository()
        
        if let report = reportRepository.getCurrentReport() {
            if let patient = patientRepository.getCurrentPatient() {
                viewState = .hasData(PatientReportViewEntity(report: report, patient: patient))
            }
        }
    }
}
