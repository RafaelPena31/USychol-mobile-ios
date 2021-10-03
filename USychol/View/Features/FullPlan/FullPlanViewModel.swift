//
//  FullPlanViewModel.swift
//  USychol
//
//  Created Fernando Rodrigues on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public class FullPlanViewModel: FullPlanViewModelType {

    // MARK: - PROPERTIES
    
    public weak var viewController: FullPlanViewControllerType?
    public var viewEntity: FullPlanViewEntity?
    public var viewState: FullPlanViewState = .isEmpty {
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

extension FullPlanViewModel: FullPlanViewControllerDelegate {
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
                               plan: .full,
                               password: currentUserInfo.password)
        
        let newUserInfoEntityTree = EntityTree(userInfo: newUserInfo, patient: userInfoEntityTree.patient, reminder: userInfoEntityTree.reminder)
        userRepository.updateData(userInfo: newUserInfoEntityTree, completionRequest: onHandleSetPlan)
    }
}
