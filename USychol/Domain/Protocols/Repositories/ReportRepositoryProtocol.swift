//
//  ReportRepositoryProtocol.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//

public protocol ReportRepositoryProtocol {
    func getReport(patientId: String) -> [Report]
    func getReportById(reportId: String) -> Report
}
