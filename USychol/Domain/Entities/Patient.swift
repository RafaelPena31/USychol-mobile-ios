//
//  Patient.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 05/08/21.
//

public enum PatientClass {
    case child
    case teen
    case adult
}

public enum PatientMaritalStatus {
    case single
    case married
    case divorced
    case widower
}

public struct Patient: Equatable {
    let name: String
    let profilePicture = "https://mk0anatomieunes58h83.kinstacdn.com/wp-content/themes/cera/assets/images/avatars/user-avatar.png"
    let patientSummary: String
    let age: String
    let patientClass: PatientClass
    let motherName: String
    let fatherName: String?
    let maritalStatus: PatientMaritalStatus
    let appointmentCount: Int
}
