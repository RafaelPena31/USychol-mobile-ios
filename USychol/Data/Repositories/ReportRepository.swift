//
//  ReportRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 08/08/21.
//

public class ReportRepository: ReportRepositoryProtocol {
    public func getReportById(reportId: String) -> Report {
        let activies = PerformActivyRepository().getPerformActivy(patientId: "0")
        
        let report = Report(id: "0", date: "04/08/2021", startAt: "04:00 PM", activies: activies, resume: "Patient told of a dream that intrigued him about a dismal Quidditch game. He described feeling very scared of being knocked out by a Slytherin student", consultEvaluation: 8)
        
        return report
    }
    
    public func getReport(patientId: String) -> [Report] {
        let activies = PerformActivyRepository().getPerformActivy(patientId: patientId)
        
        let reports = [
            Report(id: "0", date: "04/08/2021", startAt: "04:00 PM", activies: activies, resume: "Patient told of a dream that intrigued him about a dismal Quidditch game. He described feeling very scared of being knocked out by a Slytherin student", consultEvaluation: 8),
            Report(id: "1", date: "04/07/2021", startAt: "05:00 PM", activies: activies, resume: "Patient told of a dream that intrigued him about a dismal Quidditch game. He described feeling very scared of being knocked out by a Slytherin student", consultEvaluation: 8),
            Report(id: "2", date: "04/06/2021", startAt: "04:00 PM", activies: activies, resume: "Patient told of a dream that intrigued him about a dismal Quidditch game. He described feeling very scared of being knocked out by a Slytherin student", consultEvaluation: 8),
            Report(id: "3", date: "04/05/2021", startAt: "04:00 PM", activies: activies, resume: "Patient told of a dream that intrigued him about a dismal Quidditch game. He described feeling very scared of being knocked out by a Slytherin student", consultEvaluation: 8),
        ]
        
        return reports
    }
}
