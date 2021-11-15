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

public struct Patient: Equatable, Codable {
    let id: String
    
    let name: String
    var profilePicture = "https://mk0anatomieunes58h83.kinstacdn.com/wp-content/themes/cera/assets/images/avatars/user-avatar.png"
    let patientSummary: String
    let age: String
    let patientClass: String
    let motherName: String
    let fatherName: String?
    let maritalStatus: String
    let appointmentCount: Int
    let reports: [Report]
    
    let fromUser: String
}

public struct PatientFB: Codable {
    let id: String
    
    let name: String
    var profilePicture = "https://mk0anatomieunes58h83.kinstacdn.com/wp-content/themes/cera/assets/images/avatars/user-avatar.png"
    let patientSummary: String
    let age: String
    let patientClass: String
    let motherName: String
    let fatherName: String?
    let maritalStatus: String
    let appointmentCount: Int
    
    let fromUser: String
}
