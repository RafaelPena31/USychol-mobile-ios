//
//  PerformActivyRepositoryProtocol.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//

public protocol PerformActivyRepositoryProtocol {
    func getPerformActivy(patientId: String) -> [PerformActivy]
}
