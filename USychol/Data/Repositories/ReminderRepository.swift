//
//  ReminderRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 30/07/21.
//
import Foundation

public class ReminderRepository: ReminderRepositoryProtocol {
    public func createReminder(title: String) -> Bool {
        let userRepository = UserRepository()
        let userInfoEntityTree = userRepository.getUser()!
        
        var reminders = userInfoEntityTree.reminder
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        let startHour = formatter.string(from: Date().addingTimeInterval(60 * 60))
        let endHour = formatter.string(from: Date().addingTimeInterval(2 * (60 * 60)))

        let newReminder = Reminder(id: UUID().uuidString,
                                   title: title,
                                   startAt: startHour,
                                   endAt: endHour,
                                   profilePicture: nil,
                                   age: nil,
                                   fromUser: userInfoEntityTree.userInfo.id)
        
        reminders.insert(newReminder, at: 0)
        
        let newUserInfoEntityTree = EntityTree(userInfo: userInfoEntityTree.userInfo, patient: userInfoEntityTree.patient, reminder: reminders)
        
        return userRepository.updateData(userInfo: newUserInfoEntityTree)
    }
    
    public func getReminders(userId: String) -> [Reminder] {
        let userInfoEntityTree = UserRepository().getUser()
        
        if let reminders = userInfoEntityTree?.reminder {
            return reminders
        }
        
        return []
    }
}
