//
//  DigitalPlanViewModel.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class DigitalPlanViewModel: DigitalPlanViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: DigitalPlanViewControllerType?
    public var viewEntity: DigitalPlanViewEntity?
    public var viewState: DigitalPlanViewState = .isEmpty {
        didSet {
            viewController?.updateView(with: viewState)
        }
    }
    
    // MARK: - INITIALIZERS

    public init() {

    }
    
    // MARK: - PUBLIC API

    public func initState() {
        
    }
}

extension DigitalPlanViewModel: DigitalPlanViewControllerDelegate {
    public func setPlan(_ onHandleSetPlan: @escaping (_ updateStatus: Bool) -> Void) {
        let userRepository = UserRepository()
        let userInfoEntityTree = userRepository.getUser()!
        let currentUserInfo = userInfoEntityTree.userInfo
        
        let newUserInfo = User(id: currentUserInfo.id,
                               name: currentUserInfo.name,
                               email: currentUserInfo.email,
                               age: currentUserInfo.age,
                               crp: currentUserInfo.crp,
                               cpf: currentUserInfo.cpf,
                               plan: .digital,
                               password: currentUserInfo.password)
        
        let newUserInfoEntityTree = EntityTree(userInfo: newUserInfo, patient: userInfoEntityTree.patient, reminder: userInfoEntityTree.reminder)
        userRepository.updateData(userInfo: newUserInfoEntityTree, completionRequest: onHandleSetPlan)
    }
}
