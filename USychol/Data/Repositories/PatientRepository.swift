//
//  PatientRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 05/08/21.
//

public class PatientRepository: PatientRepositoryProtocol {
    public func getPatientById(patientId: String) -> Patient {
        let patient = Patient(name: "Darlan Ribeiro", patientSummary: "The patient demonstrates hyperactivity and loss of focus in their daily tasks. He reported feelings of loneliness and longing for his parents for having gone to live at the school at an early age.", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2)
        
        return patient
    }
    
    public func getPatients(userId: String) -> [Patient] {
        let patients = [
            Patient(name: "Darlan Ribeiro", patientSummary: "The patient demonstrates hyperactivity and loss of focus in their daily tasks. He reported feelings of loneliness and longing for his parents for having gone to live at the school at an early age.", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", patientSummary: "The patient demonstrates hyperactivity and loss of focus in their daily tasks. He reported feelings of loneliness and longing for his parents for having gone to live at the school at an early age.", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", patientSummary: "The patient demonstrates hyperactivity and loss of focus in their daily tasks. He reported feelings of loneliness and longing for his parents for having gone to live at the school at an early age.", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", patientSummary: "The patient demonstrates hyperactivity and loss of focus in their daily tasks. He reported feelings of loneliness and longing for his parents for having gone to live at the school at an early age.", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", patientSummary: "The patient demonstrates hyperactivity and loss of focus in their daily tasks. He reported feelings of loneliness and longing for his parents for having gone to live at the school at an early age.", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", patientSummary: "The patient demonstrates hyperactivity and loss of focus in their daily tasks. He reported feelings of loneliness and longing for his parents for having gone to live at the school at an early age.", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", patientSummary: "The patient demonstrates hyperactivity and loss of focus in their daily tasks. He reported feelings of loneliness and longing for his parents for having gone to live at the school at an early age.", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2),
            Patient(name: "Darlan Ribeiro", patientSummary: "The patient demonstrates hyperactivity and loss of focus in their daily tasks. He reported feelings of loneliness and longing for his parents for having gone to live at the school at an early age.", age: "16", patientClass: .teen, motherName: "Maria Antonieta Ribeiro", fatherName: "Jobert Ribeiro", maritalStatus: .single, appointmentCount: 2)
        ]
        return patients
    }
}

