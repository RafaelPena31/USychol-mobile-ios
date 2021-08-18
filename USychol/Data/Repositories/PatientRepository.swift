//
//  PatientRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 05/08/21.
//
import Foundation

public class PatientRepository: PatientRepositoryProtocol {
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
}

