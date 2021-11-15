//
//  PatientRepositoryProtocol.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 05/08/21.
//

public protocol PatientRepositoryProtocol {
    func getPatients() -> [Patient]
    func getPatientById(patientId: String) -> Patient?
    func createPatient(patient: PatientFB, completionRequest:@escaping (_ state: Bool) -> Void) -> Void
    func updatePatient(patient: Patient, completionRequest:@escaping (_ state: Bool) -> Void) -> Void
    func setCurrentPatient(patient: Patient) -> Bool
    func getCurrentPatient() -> Patient?
}
