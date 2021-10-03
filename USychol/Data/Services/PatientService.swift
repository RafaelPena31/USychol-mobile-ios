//
//  UserService.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 02/10/21.
//

import Foundation

public class PatientService {
    private let baseUrl = "https://6155212b2473940017efb080.mockapi.io/usychol/api/v1/users"
    private let urlSession = URLSession.shared
    
    public func getPatients(userId: String, currentUserInfo: User, completionRequest:@escaping (_ state: [Patient], _ currentUserInfo: User) -> Void) {
        if let URL = URL(string: "\(baseUrl)/\(userId)/patients") {
            urlSession.dataTask(with: URL) { data, response, error in
                if let data = data {
                    do {
                        let patientsData = try JSONDecoder().decode([Patient].self, from: data)
                        completionRequest(patientsData, currentUserInfo)
                    } catch {
                        print("Erro de parse")
                    }
                }
            }.resume()
        }
    }
}
