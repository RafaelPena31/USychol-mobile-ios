//
//  ReportRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//

public class ReportRepository: ReportRepositoryProtocol {
    public func getReportById(patientId: String, reportId: String) -> Report? {
        if let patients = PatientRepository().getPatientById(patientId: patientId) {
            let reports = patients.reports
            
            let currentReport = reports.first(where: {$0.id == reportId})
            
            return currentReport
        }
        
        return nil
    }
    
    public func getReports(patientId: String) -> [Report] {
        if let patients = PatientRepository().getPatientById(patientId: patientId) {
            let reports = patients.reports
            
            return reports
        }
        
        return []
    }
}
