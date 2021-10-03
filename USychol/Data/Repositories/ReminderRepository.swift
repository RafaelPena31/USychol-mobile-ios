//
//  ReminderRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 30/07/21.
//
import Foundation

public class ReminderRepository: ReminderRepositoryProtocol {
    private let baseUrl = "https://6155212b2473940017efb080.mockapi.io/usychol/api/v1/reminders"
    private let urlSession = URLSession.shared
    
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
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
        
        func setRequestState(_ state: Bool) {
            requestState = state
        }
        
        let userRepository = UserRepository()
        let userInfoEntityTree = userRepository.getUser()!
        
        var reminders = userInfoEntityTree.reminder
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        let startHour = formatter.string(from: Date().addingTimeInterval(60 * 60))
        let endHour = formatter.string(from: Date().addingTimeInterval(2 * (60 * 60)))

        let newReminder = Reminder(id: "",
                                   title: title,
                                   startAt: startHour,
                                   endAt: endHour,
                                   profilePicture: nil,
                                   age: nil,
                                   fromUser: userInfoEntityTree.userInfo.id)
        
        reminders.insert(newReminder, at: 0)
        
        let newUserInfoEntityTree = EntityTree(userInfo: userInfoEntityTree.userInfo, patient: userInfoEntityTree.patient, reminder: reminders)
        
        do {
            let reminderData = try encoder.encode(newReminder)
            
            if let URL = URL(string: "\(self.baseUrl)") {
                var urlRequest = URLRequest(url: URL)
                urlRequest.httpMethod = "POST"
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
                urlRequest.httpBody = reminderData
                
                self.urlSession.dataTask(with: urlRequest) { data, response, error in
                    if data != nil {
                        userRepository.updateData(userInfo: newUserInfoEntityTree, completionRequest: setRequestState)
                    }
                }.resume()
            }
        } catch let err {
            let errMsg = err.localizedDescription
            print("Unable to verify the data in CreateReminder - Reminder Repository - Error: \(errMsg)")
        }
    }
    
    public func getReminders(userId: String) -> [Reminder] {
        let userInfoEntityTree = UserRepository().getUser()
        
        if let reminders = userInfoEntityTree?.reminder {
            return reminders
        }
        
        return []
    }
}
