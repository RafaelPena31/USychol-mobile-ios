//
//  ReminderTableView.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 30/07/21.
//

import UIKit

final class ReminderTableView: UITableView {
    // MARK: - UI
    
    private lazy var coreTableViewEmptyState: CoreTableViewEmptyState = {
        let view = CoreTableViewEmptyState(imageName: "no-reminder-data", labelProps: (text: "No remindes for you today :)", color: "PurpleStrongLightColor"))
        
        return view
    }()
    
    // MARK: - INITIALIZERS
    
    init(frame: CGRect = .zero) {
        super.init(frame: frame, style: .plain)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setup() {
        buildStyle()
        
        self.backgroundView = coreTableViewEmptyState
    }
    
    private func buildStyle() {
        self.separatorStyle = .none
        self.backgroundColor = UIColor(named: "MainPurpleColor")
    }
}
