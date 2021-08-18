//
//  UserDefaults+.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 17/08/21.
//

import Foundation

extension UserDefaults {

    func setLoggedIn(value: Bool) {
        set(value, forKey: AuthDefaultsKeys.isLoggedIn.rawValue)
    }

    func isLoggedIn()-> Bool {
        return bool(forKey: AuthDefaultsKeys.isLoggedIn.rawValue)
    }

    func setUserID(value: String){
        set(value, forKey: AuthDefaultsKeys.userID.rawValue)
    }

    func getUserID() -> String {
        return string(forKey: AuthDefaultsKeys.userID.rawValue) ?? ""
    }
}
