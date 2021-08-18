//
//  ReportRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//
import Foundation

public class ReportRepository: ReportRepositoryProtocol {
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    // MARK: - BUSINESS RULE
    
    public func createReport(report: Report) -> Bool {
        let userRepository = UserRepository()
        let patientRepository = PatientRepository()
        
        let currentUserInfo = userRepository.getUser()!
        var currentPatientsArrayInfo = currentUserInfo.patient
        
        let currentPatientInfo = patientRepository.getCurrentPatient()!
        var reportsInfo = currentPatientInfo.reports
        reportsInfo.insert(report, at: 0)
        let newCurrentPatientInfo = Patient(id: currentPatientInfo.id,
                                            name: currentPatientInfo.name,
                                            patientSummary: currentPatientInfo.patientSummary,
                                            age: currentPatientInfo.age,
                                            patientClass: currentPatientInfo.patientClass,
                                            motherName: currentPatientInfo.motherName,
                                            fatherName: currentPatientInfo.fatherName,
                                            maritalStatus: currentPatientInfo.maritalStatus,
                                            appointmentCount: currentPatientInfo.appointmentCount,
                                            reports: reportsInfo,
                                            fromUser: currentPatientInfo.fromUser)
        
        let currentPatientInfoIndex = currentPatientsArrayInfo.firstIndex(where: {$0.id == currentPatientInfo.id})!
        currentPatientsArrayInfo.remove(at: currentPatientInfoIndex)
        currentPatientsArrayInfo.insert(newCurrentPatientInfo, at: 0)
        
        let newCurrentUserInfo = EntityTree(userInfo: currentUserInfo.userInfo, patient: currentPatientsArrayInfo, reminder: currentUserInfo.reminder)
        
        let updateUserState = userRepository.updateData(userInfo: newCurrentUserInfo)
        let updatePatientUserState = patientRepository.setCurrentPatient(patient: newCurrentPatientInfo)
        
        return updateUserState && updatePatientUserState
    }
    
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
    
    public func setCurrentReport(report: Report) -> Bool {
        do {
            let reportData = try encoder.encode(report)
            localStorage.set(reportData, forKey: "currentReport")
            
            return true
        } catch let err {
            let errMsg = err.localizedDescription
            print("Unable to set the current report data in setCurrentReport - Report Repository - Error: \(errMsg)")
            
            return false
        }
    }
    
    public func getCurrentReport() -> Report? {
        do {
            if let currentReportData = localStorage.data(forKey: "currentReport") {
                let currentReportInfo = try decoder.decode(Report.self, from: currentReportData)
                
                return currentReportInfo
            }
        } catch let err {
            let errMsg = err.localizedDescription
            print("Unable to set the current report data in setCurrentReport - Report Repository - Error: \(errMsg)")
            
            return nil
        }
        return nil
    }
}
