//
//  UserRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 13/08/21.
//

import Foundation

public class UserRepository: UserRepositoryProtocol {
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    // MARK: - BUSINESS RULE
    
    public func signIn(email: String, password: String) -> EnumAuthResponse {
        if let data = localStorage.data(forKey: "users") {
            do {
                let usersInfo = try decoder.decode([AuthEntityTree].self, from: data)
                if let currentUserInfo = usersInfo.first(where: {$0.entity.userInfo.email == email && $0.entity.userInfo.password == password}) {
                    localStorage.setLoggedIn(value: true)
                    localStorage.setUserID(value: currentUserInfo.userID)
                    
                    let userData = try encoder.encode(currentUserInfo)
                    localStorage.set(userData, forKey: "currentUserData")
                    
                    return .authenticated
                }
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to verify the data in SignIn - User Repository - Error: \(errMsg)")
                return .error(errMsg)
            }
        }
        return .unauthenticated
    }
    
    public func signUp(name: String, email: String, age: String, crp: String, cpf: String, password: String) -> EnumAuthResponse {
        let userID = UUID().uuidString
        let user = User(id: userID, name: name, email: email, age: age, crp: crp, cpf: cpf, plan: nil, password: password)
        
        let entityTree = EntityTree(userInfo: user, patient: [], reminder: [])
        let authEntityTree = AuthEntityTree(userID: userID, entity: entityTree)
        
        if let data = localStorage.data(forKey: "users") {
            do {
                var usersInfo = try decoder.decode([AuthEntityTree].self, from: data)
                usersInfo.append(authEntityTree)
                
                let newUsersData =  try encoder.encode(usersInfo)
                localStorage.set(newUsersData, forKey: "users")
                
                return .authenticated
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to save the data in SignUp - User Repository - Error: \(errMsg)")
                return .error(errMsg)
            }
        } else {
            do {
                let newUsersData =  try encoder.encode([authEntityTree])
                localStorage.set(newUsersData, forKey: "users")
                return .authenticated
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to save the data in SignUp - User Repository: [First Save] - Error: \(errMsg)")
                return .error(errMsg)
            }
        }
    }
    
    public func getUser() -> EntityTree? {
        if let userData = localStorage.data(forKey: "currentUserData") {
            do {
                let userInfo = try decoder.decode(AuthEntityTree.self, from: userData)
                return userInfo.entity
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to save the data in SignUp - User Repository: [First Save] - Error: \(errMsg)")
                return nil
            }
        }
        return nil
    }
    
    public func updateData(userInfo: EntityTree) -> Bool {
        if let usersData = localStorage.data(forKey: "users") {
            do {
                let userId = userInfo.userInfo.id
                var usersInfoArray = try decoder.decode([AuthEntityTree].self, from: usersData)
                
                let currentUserInfoIndex = usersInfoArray.firstIndex(where: {$0.userID == userId})!
                usersInfoArray.remove(at: currentUserInfoIndex)
                
                let newCurrentUser = AuthEntityTree(userID: userId, entity: userInfo)
                usersInfoArray.append(newCurrentUser)
                
                let newCurrentUserData = try encoder.encode(newCurrentUser)
                let newUsersInfoArrayData = try encoder.encode(usersInfoArray)
                
                localStorage.set(newCurrentUserData, forKey: "currentUserData")
                localStorage.set(newUsersInfoArrayData, forKey: "users")
                
                return true
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to save the data in SignUp - User Repository: [First Save] - Error: \(errMsg)")
                return false
            }
        }
        return false
    }
}
