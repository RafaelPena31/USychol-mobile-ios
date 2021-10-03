//
//  ClinicFormProtocols.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 07/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public protocol ClinicFormViewControllerType: AnyObject {
    var contentView: ClinicFormViewType? { get }
    var viewModel: ClinicFormViewModelType? { get }
    var delegate: ClinicFormViewControllerDelegate? { get set }
    func updateView(with viewState: ClinicFormViewState)
}

public protocol ClinicFormViewModelType: AnyObject {
    var viewController: ClinicFormViewControllerType? { get }
    var viewEntity: ClinicFormViewEntity? { get set }
    var viewState: ClinicFormViewState { get }
    
    func initState()
}

public protocol ClinicFormViewControllerDelegate: AnyObject {
    func onHandleUpdateClinicUserData(clinicUser: User, onHandleUpdated:@escaping (_ state: Bool) -> Void) -> Void
    func onHandleDeleteAccount(onHandleUpdated:@escaping (_ state: Bool) -> Void) -> Void
    func logOut(logOutView: () -> Void) -> Void
}
