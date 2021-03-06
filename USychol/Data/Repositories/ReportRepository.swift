//
//  ReportRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//

import Foundation
import Firebase
import CodableFirebase

public class ReportRepository: ReportRepositoryProtocol {
    private let baseUrl = "https://6155212b2473940017efb080.mockapi.io/usychol/api/v1/users"
    private let urlSession = URLSession.shared
    
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    let firestoreDB = Firestore.firestore()
    
    // MARK: - BUSINESS RULE
    
    public func createReport(report: Report, onHandleUpdated: @escaping (Bool) -> Void) -> Void {
        var requestState: Bool = false {
            didSet {
                if requestState {
                    DispatchQueue.main.async {
                        onHandleUpdated(requestState)
                    }
                }
            }
        }
        
        let userRepository = UserRepository()
        let patientRepository = PatientRepository()
        
        let reportId = UUID().uuidString
        let currentPatientInfo = patientRepository.getCurrentPatient()!
        
        func setRequestState(_ state: Bool) {
            requestState = state
        }
        
        func createNewReport() -> Report {
            let newReport = Report(id: reportId,
                                   date: report.date,
                                   startAt: report.startAt,
                                   activies: report.activies,
                                   resume: report.resume,
                                   consultEvaluation: report.consultEvaluation,
                                   fromPatient: currentPatientInfo.id)
            return newReport
        }
        
        func updateLocalStorage(_ newReport: Report) {
            let currentUserInfo = userRepository.getUser()!
            var currentPatientsArrayInfo = currentUserInfo.patient
            
            var reportsInfo = currentPatientInfo.reports
            reportsInfo.insert(newReport, at: 0)
            
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
            
            userRepository.updateData(userInfo: newCurrentUserInfo, completionRequest: setRequestState)
        }
        
        func updateFromDB() {
            do {
                let newReport = createNewReport()
                let reportData = try FirestoreEncoder().encode(newReport)
                firestoreDB.collection("reports").document(reportId).setData(reportData) { err in
                    if let err = err {
                        let errMsg = err.localizedDescription
                        setRequestState(false)
                        
                        print(errMsg)
                    } else {
                        updateLocalStorage(newReport)
                    }
                }
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to verify the data in CreateReport - Report Repository - Error: \(errMsg)")
            }
        }
        
        updateFromDB()
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
