//
//  Report.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//

public struct Report: Equatable {
    let id: String
    let date: String
    let startAt: String
    let activies: [PerformActivy]
    let resume: String
    let consultEvaluation: Int
}
