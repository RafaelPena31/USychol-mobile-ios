//
//  UserRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 13/08/21.
//

import Foundation

public class UserRepository: UserRepositoryProtocol {
    private let baseUrl = "https://6155212b2473940017efb080.mockapi.io/usychol/api/v1/users"
    private let urlSession = URLSession.shared
    
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    // MARK: - BUSINESS RULE
    
    public func signIn(email: String, password: String, completionRequest:@escaping (_ state: EnumAuthResponse) -> Void) {
        var authState: EnumAuthResponse? = nil {
            didSet {
                if let authState = authState {
                    DispatchQueue.main.async {
                        completionRequest(authState)
                    }
                }
            }
        }
        
        func setAuthState(_ state: EnumAuthResponse) {
            authState = state
        }
        
        if let URL = URL(string: self.baseUrl) {
            self.urlSession.dataTask(with: URL) { data, response, error in
                if let data = data {
                    do {
                        let usersData = try self.decoder.decode([User].self, from: data)
                        if let currentUserInfo = UserService().sign(usersData: usersData, email: email, password: password) {
                            UserService().getUser(currentUserInfo: currentUserInfo, setAuthState: setAuthState)
                        } else {
                            setAuthState(.unauthenticated)
                        }
                    } catch let err {
                        let errMsg = err.localizedDescription
                        print("Unable to verify the data in SignIn - User Repository - Error: \(errMsg)")
                        setAuthState(.error(errMsg))
                    }
                }
            }.resume()
        }
    }
    
    public func logOut(_ logOutView: () -> Void) -> Void {
        localStorage.removeObject(forKey: "currentUserData")
        localStorage.setLoggedIn(value: false)
        localStorage.setUserID(value: "")
        
        logOutView()
    }
    
    public func signUp(user: User, completionRequest:@escaping (_ state: EnumAuthResponse) -> Void) {
        var authState: EnumAuthResponse? = nil {
            didSet {
                if let authState = authState {
                    DispatchQueue.main.async {
                        completionRequest(authState)
                    }
                }
            }
        }
        
        func setAuthState(_ state: EnumAuthResponse) {
            authState = state
        }
        
        do {
            let userData = try encoder.encode(user)
            
            if let URL = URL(string: self.baseUrl) {
                var urlRequest = URLRequest(url: URL)
                urlRequest.httpMethod = "POST"
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
                urlRequest.httpBody = userData
                
                self.urlSession.dataTask(with: urlRequest) { data, response, error in
                    if let data = data {
                        do {
                            let userResponse = try JSONDecoder().decode(User.self, from: data)
                            UserService().getUser(currentUserInfo: userResponse, setAuthState: setAuthState)
                        } catch let err {
                            let errMsg = err.localizedDescription
                            print("Unable to verify the data in SignUp - User Repository - Error: \(errMsg)")
                            setAuthState(.error(errMsg))
                        }
                    }
                }.resume()
            }
        } catch let err {
            let errMsg = err.localizedDescription
            print("Unable to verify the data in SignUp - User Repository - Error: \(errMsg)")
        }
    }
    
    public func getUser() -> EntityTree? {
        if let userData = localStorage.data(forKey: "currentUserData") {
            do {
                let userInfo = try decoder.decode(AuthEntityTree.self, from: userData)
                return userInfo.entity
            } catch let err {
                let errMsg = err.localizedDescription
                print("Unable to get the data in getUser - User Repository - Error: \(errMsg)")
                return nil
            }
        }
        return nil
    }
    
    public func updateData(userInfo: EntityTree, completionRequest:@escaping (_ state: Bool) -> Void) {
        var verifyState: EnumAuthResponse? = nil {
            didSet {
                if let verifyState = verifyState {
                    DispatchQueue.main.async {
                        switch verifyState {
                            case .authenticated:
                                completionRequest(true)
                                break
                            default:
                                completionRequest(false)
                                break
                        }
                    }
                }
            }
        }
        
        func setVerifyState(_ state: EnumAuthResponse) {
            verifyState = state
        }
        
        do {
            let userData = try encoder.encode(userInfo.userInfo)
            
            if let URL = URL(string: "\(self.baseUrl)/\(userInfo.userInfo.id)") {
                var urlRequest = URLRequest(url: URL)
                urlRequest.httpMethod = "PUT"
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
                urlRequest.httpBody = userData
                
                self.urlSession.dataTask(with: urlRequest) { data, response, error in
                    if let data = data {
                        do {
                            let userResponse = try JSONDecoder().decode(User.self, from: data)
                            UserService().getUser(currentUserInfo: userResponse, setAuthState: setVerifyState)
                        } catch let err {
                            let errMsg = err.localizedDescription
                            print("Unable to verify the data in SignUp - User Repository - Error: \(errMsg)")
                            setVerifyState(.error(errMsg))
                        }
                    }
                }.resume()
            }
        } catch let err {
            let errMsg = err.localizedDescription
            print("Unable to update the data in updateData - User Repository - Error: \(errMsg)")
        }
    }
    
    public func deleteAccount(userInfo: EntityTree, completionRequest: @escaping (Bool) -> Void) {
        var verifyState: Bool = false {
            didSet {
                if verifyState {
                    DispatchQueue.main.async {
                        completionRequest(verifyState)
                    }
                }
            }
        }
        
        func setVerifyState(_ state: Bool) {
            verifyState = state
        }
        
        if let URL = URL(string: "\(self.baseUrl)/\(userInfo.userInfo.id)") {
            var urlRequest = URLRequest(url: URL)
            urlRequest.httpMethod = "DELETE"
            
            self.urlSession.dataTask(with: urlRequest) { data, response, error in
                if data != nil {
                    setVerifyState(true)
                }
            }.resume()
        }
    }
}
