//
//  PerformActivyRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//

public class PerformActivyRepository: PerformActivyRepositoryProtocol {
    public func getPerformActivy(patientId: String) -> [PerformActivy] {
        let activies = [
            PerformActivy(name: "Thought of the day", deliveryDay: "04/08/2021", description: "..."),
            PerformActivy(name: "Thought of the day", deliveryDay: "04/08/2021", description: "..."),
            PerformActivy(name: "Thought of the day", deliveryDay: "04/08/2021", description: "...")
        ]
        
        return activies
    }
}
