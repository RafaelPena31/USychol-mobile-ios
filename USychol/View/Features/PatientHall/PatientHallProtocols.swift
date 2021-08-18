//
//  PatientHallProtocols.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 29/07/21.
//
//

public protocol PatientHallViewControllerType: AnyObject {
    var contentView: PatientHallViewType? { get }
    var viewModel: PatientHallViewModelType? { get }
    var delegate: PatientHallViewControllerDelegate? { get set }
    func updateView(with viewState: PatientHallViewState)
}

public protocol PatientHallViewModelType: AnyObject {
    var viewController: PatientHallViewControllerType? { get }
    var viewEntity: PatientHallViewEntity? { get set }
    var viewState: PatientHallViewState { get }
    
    func initState()
    func updateState()
}

public protocol PatientHallViewControllerDelegate: AnyObject {
    func onHandleAddReminder(_ text: String) -> Bool
    func setCurrentPatient(patient: Patient) -> Bool
}

public protocol PatientHallViewControllerViewDelegate: AnyObject {
    func reloadData()
}
