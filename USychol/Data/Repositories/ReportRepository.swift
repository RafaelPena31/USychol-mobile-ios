//
//  ReportRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//
import Foundation

public class ReportRepository: ReportRepositoryProtocol {
    private let baseUrl = "https://6155212b2473940017efb080.mockapi.io/usychol/api/v1/users"
    private let urlSession = URLSession.shared
    
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
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
        
        func setRequestState(_ state: Bool) {
            requestState = state
        }
        
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
        
        do {
            let reportData = try encoder.encode(report)
            
            if let URL = URL(string: "\(self.baseUrl)/\(currentUserInfo.userInfo.id)/patients/\(currentPatientInfo.id)/reports") {
                var urlRequest = URLRequest(url: URL)
                urlRequest.httpMethod = "POST"
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
                urlRequest.httpBody = reportData
                
                self.urlSession.dataTask(with: urlRequest) { data, response, error in
                    if let data = data {
                        do {
                            let newReport = try self.decoder.decode(Report.self, from: data)
                            reportsInfo.append(newReport)
                            
                            let newPatient = Patient(id: currentPatientInfo.id,
                                                     name: currentPatientInfo.name,
                                                     profilePicture: currentPatientInfo.profilePicture,
                                                     patientSummary: currentPatientInfo.patientSummary,
                                                     age: currentPatientInfo.age,
                                                     patientClass: currentPatientInfo.patientClass,
                                                     motherName: currentPatientInfo.motherName,
                                                     fatherName: currentPatientInfo.fatherName,
                                                     maritalStatus: currentPatientInfo.maritalStatus,
                                                     appointmentCount: currentPatientInfo.appointmentCount,
                                                     reports: reportsInfo,
                                                     fromUser: currentPatientInfo.fromUser)
                            
                            userRepository.updateData(userInfo: newCurrentUserInfo, completionRequest: setRequestState)
                            patientRepository.updatePatient(patient: newPatient, completionRequest: setRequestState)
                        } catch let err {
                            let errMsg = err.localizedDescription
                            print("Unable to verify the data in CreateReport - Report Repository - Error: \(errMsg)")
                        }
                    }
                }.resume()
            }
        } catch let err {
            let errMsg = err.localizedDescription
            print("Unable to verify the data in CreateReport - Report Repository - Error: \(errMsg)")
        }
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
