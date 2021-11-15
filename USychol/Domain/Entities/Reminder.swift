//
//  Reminder.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 30/07/21.
//

public struct Reminder: Equatable, Codable {
    let id: String
    
    let title: String
    let startAt: String
    let endAt: String?
    let profilePicture: String?
    let age: String?
    
    let fromUser: String
}

struct ReminderFB: Codable {
    let reminders: [Reminder]
}
