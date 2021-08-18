//
//  Report.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//

public struct Report: Equatable, Codable {
    let id: String
    
    let date: String
    let startAt: String
    let activies: [String]
    let resume: String
    let consultEvaluation: Int
    
    let fromPatient: String
}
