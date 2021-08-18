//
//  PatientRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 05/08/21.
//
import Foundation

public class PatientRepository: PatientRepositoryProtocol {
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    // MARK: - BUSINESS RULE
    
    public func createPatient(patient: Patient) -> Bool {
        let userRepository = UserRepository()
        if let userInfoEntityTree = userRepository.getUser() {
            var patients = userInfoEntityTree.patient
            patients.append(patient)
                
            let newUserInfoEntityTree = EntityTree(userInfo: userInfoEntityTree.userInfo, patient: patients, reminder: userInfoEntityTree.reminder)
            let updateStatus = userRepository.updateData(userInfo: newUserInfoEntityTree)
                
            return updateStatus
        }
        return false
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

