//
//  ClinicFormViewModel.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 07/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class ClinicFormViewModel: ClinicFormViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: ClinicFormViewControllerType?
    public var viewEntity: ClinicFormViewEntity?
    public var viewState: ClinicFormViewState = .isEmpty {
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
    
    // MARK: - PRIVATES
    
    private func updateState() {
        let userRepository = UserRepository()
        if let clinicUser = userRepository.getUser()?.userInfo {
            viewState = .hasData(ClinicFormViewEntity(clinicUser: clinicUser))
        }
    }
}

extension ClinicFormViewModel: ClinicFormViewControllerDelegate {
    public func onHandleDeleteAccount(onHandleUpdated: @escaping (Bool) -> Void) {
        let userRepository = UserRepository()
        if let currentUserInfoEntityTree = userRepository.getUser() {
            userRepository.deleteAccount(userInfo: currentUserInfoEntityTree, completionRequest: onHandleUpdated)
        }
    }
    
    public func onHandleUpdateClinicUserData(clinicUser: User, onHandleUpdated: @escaping (Bool) -> Void) {
        let userRepository = UserRepository()
        if let currentUserInfoEntityTree = userRepository.getUser() {
            let updatedUserInfoEntityTree = EntityTree(userInfo: clinicUser, patient: currentUserInfoEntityTree.patient, reminder: currentUserInfoEntityTree.reminder)
            
            userRepository.updateData(userInfo: updatedUserInfoEntityTree, completionRequest: onHandleUpdated)
        }
    }
    
    public func logOut(logOutView: () -> Void) {
        let userRepository = UserRepository()
        userRepository.logOut(logOutView)
    }
}
