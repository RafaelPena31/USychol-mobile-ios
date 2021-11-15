//
//  ReminderRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 30/07/21.
//
import Foundation
import Firebase
import CodableFirebase

public class ReminderRepository: ReminderRepositoryProtocol {
    
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let firestoreDB = Firestore.firestore()
    
    public func createReminder(title: String, onHandleUpdated:@escaping (_ state: Bool) -> Void) -> Void {
        var requestState: Bool = false {
            didSet {
                if requestState {
                    DispatchQueue.main.async {
                        onHandleUpdated(requestState)
                    }
                }
            }
        }
        
        let userRepository = UserRepository()
        let userInfoEntityTree = userRepository.getUser()!
        var reminders = userInfoEntityTree.reminder
        let reminderId = UUID().uuidString
        
        func setRequestState(_ state: Bool) {
            requestState = state
        }
        
        func createNewReminder(_ userId: String) -> Reminder {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            
            let startHour = formatter.string(from: Date().addingTimeInterval(60 * 60))
            let endHour = formatter.string(from: Date().addingTimeInterval(2 * (60 * 60)))

            let newCacheReminder = Reminder(id: reminderId,
                                       title: title,
                                       startAt: startHour,
                                       endAt: endHour,
                                       profilePicture: nil,
                                       age: nil,
                                       fromUser: userId)
            
            return newCacheReminder
        }
        
        func setNewRemindersObject(_ newReminderCache: Reminder) {
            do {
                reminders.insert(newReminderCache, at: 0)
                let newUserInfoEntityTree = EntityTree(userInfo: userInfoEntityTree.userInfo, patient: userInfoEntityTree.patient, reminder: reminders)
                let authEntityTree = AuthEntityTree(userID: userInfoEntityTree.userInfo.id, entity: newUserInfoEntityTree)
                
                let userData = try encoder.encode(authEntityTree)
                localStorage.set(userData, forKey: "currentUserData")
                
                setRequestState(true)
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to verify the data in CreateReminder - Reminder Repository - Error: \(errMsg)")
            }

        }
        
        func addNewReminderToDB() {
            do {
                let newReminder = createNewReminder(userInfoEntityTree.userInfo.id)
                let reminderData = try FirestoreEncoder().encode(newReminder)
                
                firestoreDB.collection("reminders").document(reminderId).setData(reminderData) { error in
                    if let error = error {
                        setRequestState(false)
                        print(error.localizedDescription)
                    } else {
                        setNewRemindersObject(newReminder)
                    }
                }
            } catch let err {
                let errMsg = err.localizedDescription
                setRequestState(false)
                
                print(errMsg)
            }
        }
        
        addNewReminderToDB()
    }
    
    public func getReminders(userId: String) -> [Reminder] {
        let userInfoEntityTree = UserRepository().getUser()
        
        if let reminders = userInfoEntityTree?.reminder {
            return reminders
        }
        
        return []
    }
}
