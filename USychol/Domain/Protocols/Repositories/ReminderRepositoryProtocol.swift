//
//  ReminderRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 30/07/21.
//

public protocol ReminderRepositoryProtocol {
    func getReminders(userId: String) -> [Reminder]
    func createReminder(title: String) -> Bool
}
