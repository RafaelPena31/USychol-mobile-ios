//
//  UserService.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 02/10/21.
//

import Foundation

public class ReminderService {
    private let baseUrl = "https://6155212b2473940017efb080.mockapi.io/usychol/api/v1/reminders"
    private let urlSession = URLSession.shared
    
    public func getReminders(userId: String, currentUserInfo: User, completionRequest:@escaping (_ state: [Reminder], _ currentUserInfo: User ) -> Void) {
        if let URL = URL(string: baseUrl) {
            urlSession.dataTask(with: URL) { data, response, error in
                if let data = data {
                    do {
                        let remindersData = try JSONDecoder().decode([Reminder].self, from: data)
                        completionRequest(remindersData.reversed(), currentUserInfo)
                    } catch {
                        print("Erro de parse")
                    }
                }
            }.resume()
        }
    }
}
