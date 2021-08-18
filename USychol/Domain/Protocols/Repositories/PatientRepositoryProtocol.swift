//
//  PatientRepositoryProtocol.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 05/08/21.
//

public protocol PatientRepositoryProtocol {
    func getPatients() -> [Patient]
    func getPatientById(patientId: String) -> Patient?
    func createPatient(patient: Patient) -> Bool
    func setCurrentPatient(patient: Patient) -> Bool
    func getCurrentPatient() -> Patient?
}
