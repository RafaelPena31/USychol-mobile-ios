//
//  ReminderRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 30/07/21.
//

public class ReminderRepository: ReminderRepositoryProtocol {
    public func getReminders(userId: String) -> [Reminder] {
        let reminders = [
            Reminder(title: "Rafael Pena", startAt: "04:00 PM", endAt: nil, profilePicture: "https://mk0anatomieunes58h83.kinstacdn.com/wp-content/themes/cera/assets/images/avatars/user-avatar.png", age: "17"),
            Reminder(title: "Rafael Pena", startAt: "05:00 PM", endAt: nil, profilePicture: "https://mk0anatomieunes58h83.kinstacdn.com/wp-content/themes/cera/assets/images/avatars/user-avatar.png", age: "17"),
            Reminder(title: "Buy alcohol today", startAt: "06:00 PM", endAt: "06:30 PM", profilePicture: nil, age: nil),
            Reminder(title: "Rafael Pena", startAt: "05:00 PM", endAt: nil, profilePicture: "https://mk0anatomieunes58h83.kinstacdn.com/wp-content/themes/cera/assets/images/avatars/user-avatar.png", age: "17"),
        ]
        
        return reminders
    }
}
