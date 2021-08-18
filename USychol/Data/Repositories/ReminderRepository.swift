//
//  ReminderRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 30/07/21.
//
import Foundation

public class ReminderRepository: ReminderRepositoryProtocol {
    public func getReminders(userId: String) -> [Reminder] {
        let userInfoEntityTree = UserRepository().getUser()
        
        if let reminders = userInfoEntityTree?.reminder {
            return reminders
        }
        
        return []
    }
}
