//
//  UserService.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 02/10/21.
//

import Foundation
import Firebase
import CodableFirebase

public class ReminderService {
    let firestoreDB = Firestore.firestore()
    
    public func getReminders(userId: String, currentUserInfo: User, completionRequest:@escaping (_ state: [Reminder], _ currentUserInfo: User ) -> Void) {
        let docRef = firestoreDB.collection("reminders").whereField("fromUser", isEqualTo: userId)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                completionRequest([], currentUserInfo)
                print("Error getting documents: \(err)")
            } else {
                var reminders: [Reminder] = []
                for document in querySnapshot!.documents {
                    let reminderFB = try! FirestoreDecoder().decode(Reminder.self, from: document.data())
                    reminders.append(reminderFB)
                }
                
                completionRequest(reminders, currentUserInfo)
            }
        }
    }
}
