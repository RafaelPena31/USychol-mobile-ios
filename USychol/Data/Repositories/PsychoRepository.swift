//
//  PsychoRepository.swift
//  USychol
//
//  Created by Fernando Rodrigues on 14/08/21.
//

import UIKit
public class PsychoRepository: PsychoRepositoryProtocol {
    let defaults = UserDefaults.standard
     
    public func signIn(email: String, password: String) -> Bool{
        if let psychoDict = defaults.value(forKey: "signUp") as? [String: Any] {
            let psycho = Psycho(
                name: psychoDict["name"] as? String ?? "",
                email: psychoDict["email"] as? String ?? "",
                registration: psychoDict["registration"] as? String ?? "",
                birthday: psychoDict["birthday"] as? String ?? "",
                idDocument: psychoDict["idDocument"] as? String ?? "",
                password: psychoDict["password"] as? String ?? "",
                plans: psychoDict["plans"] as? Plans ?? nil
            )
            if psycho.email == email && psycho.password == password {
                return true
            }
        }
        return false
    }
    
    public func signUp(psycho: Psycho) -> Void {        
        let dictPsycho = [
            "name": psycho.name,
            "email": psycho.email,
            "registration": psycho.registration,
            "birthday": psycho.birthday,
            "idDocument": psycho.idDocument,
            "password": psycho.password,
            "plans": nil
        ] as [String : String?]
        defaults.set(try? PropertyListEncoder().encode(dictPsycho), forKey: "signUp")
    }
}
