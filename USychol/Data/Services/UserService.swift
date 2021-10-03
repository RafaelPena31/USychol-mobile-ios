//
//  UserService.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 02/10/21.
//

import Foundation
import RxCocoa
import RxSwift

public class UserService {
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    public func sign(usersData: [User], email: String, password: String) -> User? {
        if usersData.count > 0 {
            if let currentUserInfo = usersData.first(where: {$0.email == email && $0.password == password}) {
                return currentUserInfo
            }
        }
        return nil
    }
    
    public func getUser(currentUserInfo: User, setAuthState:@escaping (_ state: EnumAuthResponse) -> Void) {
        let userId = currentUserInfo.id
        
        func onHandleSetUser() -> EnumAuthResponse {
            localStorage.setLoggedIn(value: true)
            localStorage.setUserID(value: userId)
            
            let entityTree = EntityTree(userInfo: currentUserInfo, patient: patients, reminder: reminders)
            let authEntityTree = AuthEntityTree(userID: userId, entity: entityTree)
            
            do {
                let userData = try encoder.encode(authEntityTree)
                localStorage.set(userData, forKey: "currentUserData")
                return .authenticated
            } catch let err {
                let errMsg = err.localizedDescription
                    return .error(errMsg)
            }
        }
            
        var patients: [Patient] = []
        func setPatient(_ cachePatients: [Patient], _ currentUserInfo: User) {
            patients = cachePatients
            ReminderService().getReminders(userId: currentUserInfo.id, currentUserInfo: currentUserInfo, completionRequest: setReminder)
        }
            
        var reminders: [Reminder] = []
        func setReminder(_ cacheReminders: [Reminder], _ currentUserInfo: User) {
            reminders = cacheReminders
            
            let authState = onHandleSetUser()
            setAuthState(authState)
        }
        
        PatientService().getPatients(userId: userId, currentUserInfo: currentUserInfo, completionRequest: setPatient)
    }
}
