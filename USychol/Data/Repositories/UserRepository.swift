//
//  UserRepository.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 13/08/21.
//

import Foundation
import Firebase
import CodableFirebase

public class UserRepository: UserRepositoryProtocol {
    // MARK: - DATA
    
    let localStorage = UserDefaults.standard
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    let firestoreDB = Firestore.firestore()
    
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
        
        func getUserFromDB(_ userId: String) {
            let docRef = firestoreDB.collection("users").document(userId)
            docRef.getDocument { doc, error in
                guard let doc = doc, let docData = doc.data() else {
                    let errMsg = error!.localizedDescription
                    print(errMsg)
                    setAuthState(.error(errMsg))
                    
                    return
                }
                
                let userFB = try! FirestoreDecoder().decode(User.self, from: docData)
                UserService().getUser(currentUserInfo: userFB, setAuthState: setAuthState)
            }
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completionRequest(.error(error.localizedDescription))
            } else {
                getUserFromDB(authResult!.user.uid)
            }
        }
    }
    
    public func logOut(_ logOutView: () -> Void) -> Void {
        do {
            try Auth.auth().signOut()
            localStorage.removeObject(forKey: "currentUserData")
            localStorage.setLoggedIn(value: false)
            localStorage.setUserID(value: "")
            
            logOutView()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
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
        
        func createUserSchemasDB(_ user: User) {
            do {
                let FBUserData = try FirestoreEncoder().encode(user)
                firestoreDB.collection("users").document(user.id).setData(FBUserData) { error in
                    if let error = error {
                        setAuthState(.error(error.localizedDescription))
                    } else {
                        UserService().getUser(currentUserInfo: user, setAuthState: setAuthState)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        
        Auth.auth().createUser(withEmail: user.email, password: user.password!) { authResult, error in
            if let error = error {
                setAuthState(.error(error.localizedDescription))
            } else {
                let newUser = User(id: authResult!.user.uid, name: user.name, email: user.email, age: user.age, crp: user.crp, cpf: user.cpf, plan: nil, password: user.password)
                createUserSchemasDB(newUser)
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
        
        func updateUserFromDB() {
            do {
                let FBUserData = try FirestoreEncoder().encode(userInfo.userInfo)
                firestoreDB.collection("users").document(userInfo.userInfo.id).setData(FBUserData) { error in
                    if let error = error {
                        setVerifyState(.error(error.localizedDescription))
                    } else {
                        UserService().getUser(currentUserInfo: userInfo.userInfo, setAuthState: setVerifyState)
                    }
                }
            } catch let err {
                let errMsg = err.localizedDescription
                setVerifyState(.error(errMsg))
                print("Unable to update the data in updateData - User Repository - Error: \(errMsg)")
            }
        }
        
        updateUserFromDB()
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
        
        func deleteUserDocsFromDB() {
            var docsForQuery: [QueryDocumentSnapshot] = []
            
            firestoreDB.collection("users").document(userInfo.userInfo.id).delete() { err in
                if let err = err {
                    setVerifyState(false)
                    print("Error removing user document: \(err)")
                    
                    return
                }
            }
            
            let patientsDocsRef = firestoreDB.collection("patients").whereField("fromUser", isEqualTo: userInfo.userInfo.id)
            patientsDocsRef.getDocuments { snp, err in
                if let err = err {
                    setVerifyState(false)
                    print("Error getting patients documents: \(err)")
                    
                    return
                } else {
                    docsForQuery.append(contentsOf: snp!.documents)
                }
            }

            let remindersDocsRef = firestoreDB.collection("reminders").whereField("fromUser", isEqualTo: userInfo.userInfo.id)
            remindersDocsRef.getDocuments { snp, err in
                if let err = err {
                    setVerifyState(false)
                    print("Error getting reminders documents: \(err)")
                    
                    return
                } else {
                    docsForQuery.append(contentsOf: snp!.documents)
                }
            }
            
            if docsForQuery.count == 0 {
                setVerifyState(true)
            } else {
                let docsForQueryArray = docsForQuery.chunked(into: 500)
                docsForQueryArray.forEach { docQuery in
                    let batchDB = firestoreDB.batch()
                    docQuery.forEach { doc in
                        batchDB.deleteDocument(doc.reference)
                    }
                    
                    batchDB.commit() { err in
                        if let err = err {
                            setVerifyState(false)
                            print("Batch Error: \(err.localizedDescription)")
                            
                            return
                        } else {
                            setVerifyState(true)
                        }
                    }
                }
            }
        }
        
        func deleteUserFromAuth() {
            let userFB = Auth.auth().currentUser
            
            userFB?.delete { error in
                if let error = error {
                    let errMsg = error.localizedDescription
                    print("Unable to delete the data in deleteAccount - User Repository - Error: \(errMsg)")
                } else {
                    deleteUserDocsFromDB()
                }
            }
        }
        
        deleteUserFromAuth()
    }
}
