//
//  SceneDelegate.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 20/07/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let localStorage = UserDefaults.standard
            
            let isLoggin = localStorage.isLoggedIn()
            
            let SplashVC = SplashViewController()
            
            let PatientHallVM = PatientHallViewModel()
            let PatientHallVC = PatientHallViewController(viewModel: PatientHallVM)
            
            PatientHallVM.viewController = PatientHallVC
            PatientHallVC.delegate = PatientHallVM
            PatientHallVC.viewDelegate = PatientHallVC.contentView
            
            let rootVC = isLoggin ? PatientHallVC : SplashVC
            
            window.rootViewController = UINavigationController(rootViewController: rootVC)
            
            self.window = window
            window.makeKeyAndVisible()
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

