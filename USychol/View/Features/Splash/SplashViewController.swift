//
//  SplashViewController.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 21/07/21.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {

    // MARK: - PROPERTIES

    public let contentView: SplashViewType?
    
    // MARK: - INITIALIZERS
    
    public init(contentView: SplashViewType = SplashView()) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    
    // MARK: - PRIVATE
    
    private func setup() {
        contentSetup()
        headerSetup()
    }
    
    private func headerSetup() {
        _ = CoreHeader(type: .secondary, navigationItem: self.navigationItem, navigationController: self.navigationController!)
    }
    
    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        contentView?.delegate = self
    }
}

extension SplashViewController: SplashViewDelegate {
    func onHandleClick() {
        let SignInVM = PatientHallViewModel()
        let SignInVC = PatientHallViewController(viewModel: SignInVM)
        
        SignInVM.viewController = SignInVC
        
        self.navigationController?.pushViewController(SignInVC, animated: true)
    }
}
