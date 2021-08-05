//
//  PatientHallViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 29/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
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
    
    // MARK: - PRIVATE METHODS
    
    private func updateState() {
        let reminderRepository = ReminderRepository()
        let reminders = reminderRepository.getReminders(userId: "0")
        
        viewState = .hasData(PatientHallViewEntity(remidersData: reminders))
    }
}
