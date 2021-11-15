//
//  PatientRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 05/08/21.
//
import Foundation
import Firebase
import CodableFirebase

public class PatientRepository: PatientRepositoryProtocol {
    
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    let firestoreDB = Firestore.firestore()
    
    // MARK: - BUSINESS RULE
    
    public func createPatient(patient: PatientFB, completionRequest:@escaping (_ state: Bool) -> Void) -> Void {
        var requestState: Bool = false {
            didSet {
                if requestState {
                    DispatchQueue.main.async {
                        completionRequest(requestState)
                    }
                }
            }
        }
        
        let patientId = UUID().uuidString
        
        func setRequestState(_ state: Bool) {
            requestState = state
        }
        
        func updateLocalStorage() {
            let userRepository = UserRepository()
            
            if let userInfoEntityTree = userRepository.getUser() {
                var patients = userInfoEntityTree.patient
                
                let newPatient = Patient(id: patientId,
                                         name: patient.name,
                                         patientSummary: patient.patientSummary,
                                         age: patient.age,
                                         patientClass: patient.patientClass,
                                         motherName: patient.motherName,
                                         fatherName: patient.fatherName,
                                         maritalStatus: patient.maritalStatus,
                                         appointmentCount: patient.appointmentCount,
                                         reports: [],
                                         fromUser: patient.fromUser)
                
                patients.append(newPatient)
                
                let newUserInfoEntityTree = EntityTree(userInfo: userInfoEntityTree.userInfo, patient: patients, reminder: userInfoEntityTree.reminder)
                userRepository.updateData(userInfo: newUserInfoEntityTree, completionRequest: setRequestState)
                
                updateDB(newPatient)
            }
        }
        
        func updateDB(_ newPatient: Patient) {
            do {
                let patientFromDB = PatientFB(id: newPatient.id,
                                              name: newPatient.name,
                                              profilePicture: newPatient.profilePicture,
                                              patientSummary: newPatient.patientSummary,
                                              age: newPatient.age,
                                              patientClass: newPatient.patientClass,
                                              motherName: newPatient.motherName,
                                              fatherName: newPatient.fatherName,
                                              maritalStatus: newPatient.maritalStatus,
                                              appointmentCount: newPatient.appointmentCount,
                                              fromUser: newPatient.fromUser)
                
                let patientData = try FirestoreEncoder().encode(patientFromDB)
                firestoreDB.collection("patients").document(patientId).setData(patientData) { err in
                    if let err = err {
                        let errMsg = err.localizedDescription
                        setRequestState(false)
                        
                        print(errMsg)
                    } else {
                        setRequestState(true)
                    }
                }
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to verify the data in CreatePatient - Patient Repository - Error: \(errMsg)")
            }
        }
        
        updateLocalStorage()
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
        
        let userRepository = UserRepository()
        
        func setRequestState(_ state: Bool) {
            requestState = state
        }
        
        func updateLocalStorage() {
            if let userInfoEntityTree = userRepository.getUser() {
                var patients = userInfoEntityTree.patient.filter { $0.id != patient.id }
                patients.append(patient)
                
                let newUserInfoEntityTree = EntityTree(userInfo: userInfoEntityTree.userInfo, patient: patients, reminder: userInfoEntityTree.reminder)
                
                userRepository.updateData(userInfo: newUserInfoEntityTree, completionRequest: setRequestState)
                _ = self.setCurrentPatient(patient: patient)
            }
        }
        
        func updateUserFromDB() {
            do {
                let patientFromDB = PatientFB(id: patient.id,
                                              name: patient.name,
                                              profilePicture: patient.profilePicture,
                                              patientSummary: patient.patientSummary,
                                              age: patient.age,
                                              patientClass: patient.patientClass,
                                              motherName: patient.motherName,
                                              fatherName: patient.fatherName,
                                              maritalStatus: patient.maritalStatus,
                                              appointmentCount: patient.appointmentCount,
                                              fromUser: patient.fromUser)
                
                let FBPatientData = try FirestoreEncoder().encode(patientFromDB)
                firestoreDB.collection("patients").document(patientFromDB.id).setData(FBPatientData) { error in
                    if let error = error {
                        let errMsg = error.localizedDescription
                        setRequestState(false)
                        print("Unable to update the data in updateData - Patient Repository - Error: \(errMsg)")
                    } else {
                        updateLocalStorage()
                    }
                }
            } catch let err {
                let errMsg = err.localizedDescription
                setRequestState(false)
                print("Unable to update the data in updateData - Patient Repository - Error: \(errMsg)")
            }
        }
        
        updateUserFromDB()
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

