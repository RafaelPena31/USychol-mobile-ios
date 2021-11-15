//
//  UserService.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 02/10/21.
//

import Foundation
import Firebase
import CodableFirebase

public class PatientService {
    let firestoreDB = Firestore.firestore()
    
    public func getPatients(userId: String, currentUserInfo: User, completionRequest:@escaping (_ state: [Patient], _ currentUserInfo: User) -> Void) {
        func getReportDocs(_ patientsFB: [PatientFB]) {
            var patients: [Patient] = [] {
                didSet {
                    if patients.count == patientsFB.count {
                        completionRequest(patients, currentUserInfo)
                    }
                }
            }
            
            patientsFB.forEach { pFB in
                var reportArray: [Report] = []
                let pId = pFB.id
                let docRef = firestoreDB.collection("reports").whereField("fromPatient", isEqualTo: pId)
                
                docRef.getDocuments() { (snp, err) in
                    if let err = err {
                        completionRequest([], currentUserInfo)
                        print("Error getting documents: \(err.localizedDescription)")
                    } else {
                        for document in snp!.documents {
                            let reportFB = try! FirebaseDecoder().decode(Report.self, from: document.data())
                            reportArray.append(reportFB)
                        }
                        
                        let newPatient = Patient(id: pFB.id,
                                                 name: pFB.name,
                                                 patientSummary: pFB.patientSummary,
                                                 age: pFB.age,
                                                 patientClass: pFB.patientClass,
                                                 motherName: pFB.motherName,
                                                 fatherName: pFB.fatherName,
                                                 maritalStatus: pFB.maritalStatus,
                                                 appointmentCount: pFB.appointmentCount,
                                                 reports: reportArray,
                                                 fromUser: pFB.fromUser)
                        
                        patients.append(newPatient)
                    }
                }
            }
        }
        
        func getPatientDocs() {
            let docRef = firestoreDB.collection("patients").whereField("fromUser", isEqualTo: userId)
            
            docRef.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    completionRequest([], currentUserInfo)
                    print("Error getting documents: \(err.localizedDescription)")
                } else {
                    var patients: [PatientFB] = []
                    
                    for document in querySnapshot!.documents {
                        let patientFB = try! FirestoreDecoder().decode(PatientFB.self, from: document.data())
                        patients.append(patientFB)
                    }
                    
                    if patients.count == 0 {
                        completionRequest([], currentUserInfo)
                    } else {
                        getReportDocs(patients)
                    }
                }
            }
        }
        
        getPatientDocs()
    }
}
