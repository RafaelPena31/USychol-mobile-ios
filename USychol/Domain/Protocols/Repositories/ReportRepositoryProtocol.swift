//
//  ReportRepositoryProtocol.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//

public protocol ReportRepositoryProtocol {
    func getReports(patientId: String) -> [Report]
    func getReportById(patientId: String, reportId: String) -> Report?
}
