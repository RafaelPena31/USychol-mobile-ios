//
//  PatientRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 05/08/21.
//

public class PatientRepository: PatientRepositoryProtocol {
    public func getPatients(userId: String) -> [Patient] {
        let patients = [
            Patient(name: "Darlan Ribeiro", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2)
        ]
        return patients
    }
}

