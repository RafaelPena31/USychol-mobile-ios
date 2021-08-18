//
//  PatientHallViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 29/07/21.
//
//

public class PatientHallViewModel: PatientHallViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: PatientHallViewControllerType?
    public var viewEntity: PatientHallViewEntity?
    public var viewState: PatientHallViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }
    
    // MARK: - INITIALIZERS

    public init() {
        
    }
    
    // MARK: - PUBLIC API

    public func initState() {
        updateState()
    }
    
    public func updateState() {
        let reminderRepository = ReminderRepository()
        let reminders = reminderRepository.getReminders(userId: "0")
        
        let patientRepository = PatientRepository()
        let patients = patientRepository.getPatients()
        
        viewState = .hasData(PatientHallViewEntity(remidersData: reminders, patientsData: patients))
    }
}

extension PatientHallViewModel: PatientHallViewControllerDelegate {
    public func setCurrentPatient(patient: Patient) -> Bool {
        let patientRepository = PatientRepository()
        let updateState = patientRepository.setCurrentPatient(patient: patient)
        
        return updateState
    }
    
    public func onHandleAddReminder(_ text: String) -> Bool {
        let reminderRepository = ReminderRepository()
        return reminderRepository.createReminder(title: text)
    }
}
