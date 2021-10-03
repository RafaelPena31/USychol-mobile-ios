//
//  PatientRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 05/08/21.
//
import Foundation

public class PatientRepository: PatientRepositoryProtocol {
    private let baseUrl = "https://6155212b2473940017efb080.mockapi.io/usychol/api/v1/users"
    private let urlSession = URLSession.shared
    
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    // MARK: - BUSINESS RULE
    
    public func createPatient(patient: Patient, completionRequest:@escaping (_ state: Bool) -> Void) -> Void {
        var requestState: Bool = false {
            didSet {
                if requestState {
                    DispatchQueue.main.async {
                        completionRequest(requestState)
                    }
                }
            }
        }
        
        func setRequestState(_ state: Bool) {
            requestState = state
        }
        
        let userRepository = UserRepository()
        if let userInfoEntityTree = userRepository.getUser() {
            var patients = userInfoEntityTree.patient
            patients.append(patient)
                
            let newUserInfoEntityTree = EntityTree(userInfo: userInfoEntityTree.userInfo, patient: patients, reminder: userInfoEntityTree.reminder)
            
            do {
                let patientData = try encoder.encode(patient)
                
                if let URL = URL(string: "\(self.baseUrl)/\(userInfoEntityTree.userInfo.id)/patients") {
                    var urlRequest = URLRequest(url: URL)
                    urlRequest.httpMethod = "POST"
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
                    urlRequest.httpBody = patientData
                    
                    self.urlSession.dataTask(with: urlRequest) { data, response, error in
                        if data != nil {
                            userRepository.updateData(userInfo: newUserInfoEntityTree, completionRequest: setRequestState)
                        }
                    }.resume()
                }
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to verify the data in CreatePatient - Patient Repository - Error: \(errMsg)")
            }
        }
    }
    
    public func updatePatient(patient: Patient, completionRequest: @escaping (Bool) -> Void) {
        var requestState: Bool = false {
            didSet {
                if requestState {
                    DispatchQueue.main.async {
                        completionRequest(requestState)
                    }
                }
            }
        }
        
        func setRequestState(_ state: Bool) {
            requestState = state
        }
        
        let userRepository = UserRepository()
        if let userInfoEntityTree = userRepository.getUser() {
            var patients = userInfoEntityTree.patient
            patients.append(patient)
                
            let newUserInfoEntityTree = EntityTree(userInfo: userInfoEntityTree.userInfo, patient: patients, reminder: userInfoEntityTree.reminder)
            
            do {
                let patientData = try encoder.encode(patient)
                
                if let URL = URL(string: "\(self.baseUrl)/\(userInfoEntityTree.userInfo.id)/patients/\(patient.id)") {
                    var urlRequest = URLRequest(url: URL)
                    urlRequest.httpMethod = "PUT"
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
                    urlRequest.httpBody = patientData
                    
                    self.urlSession.dataTask(with: urlRequest) { data, response, error in
                        if data != nil {
                            userRepository.updateData(userInfo: newUserInfoEntityTree, completionRequest: setRequestState)
                            _ = self.setCurrentPatient(patient: patient)
                        }
                    }.resume()
                }
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to verify the data in UpdatePatient - Patient Repository - Error: \(errMsg)")
            }
        }
    }
    
    public func getPatientById(patientId: String) -> Patient? {
        let userInfoEntityTree = UserRepository().getUser()
        
        if let patients = userInfoEntityTree?.patient {
            let currentPatient = patients.first(where: {$0.id == patientId})
            return currentPatient
        }
        
        return nil
    }
    
    public func getPatients() -> [Patient] {
        let userInfoEntityTree = UserRepository().getUser()
        
        if let patients = userInfoEntityTree?.patient {
            return patients
        }
        
        return []
    }
    
    public func setCurrentPatient(patient: Patient) -> Bool {
        do {
            let patientData = try encoder.encode(patient)
            localStorage.set(patientData, forKey: "currentPatient")
            
            return true
        } catch let err {
            let errMsg = err.localizedDescription
            print("Unable to set the current patient data in setCurrentPatient - Patient Repository - Error: \(errMsg)")
            
            return false
        }
    }
    
    public func getCurrentPatient() -> Patient? {
        do {
            if let currentPatientData = localStorage.data(forKey: "currentPatient") {
                let currentPatientInfo = try decoder.decode(Patient.self, from: currentPatientData)
                
                return currentPatientInfo
            }
        } catch let err {
            let errMsg = err.localizedDescription
            print("Unable to set the current patient data in setCurrentPatient - Patient Repository - Error: \(errMsg)")
            
            return nil
        }
        return nil
    }
}

