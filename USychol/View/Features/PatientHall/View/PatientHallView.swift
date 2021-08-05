//
//  PatientHallView.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 29/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import SnapKit

final public class PatientHallView: UIView {
    
    // MARK: - PROPERTIES
    
    var reminderData: [Reminder] = []
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "WhiteColor")
        
        return view
    }()
    
    private lazy var reminderTextField: ReminderTextField = {
        let textField = ReminderTextField(insets: UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 16), placeholder: "Create reminder", onHandleClickAdd: onHandleAddReminder)
        
        return textField
    }()
    
    private lazy var reminderTableView: ReminderTableView = {
        let tableView = ReminderTableView()
        
        tableView.register(ReminderTableViewCell.self, forCellReuseIdentifier: "reminderCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var dividerView: UIView = {
        let divider = UIView()
        
        divider.backgroundColor = .white
        divider.layer.cornerRadius = 1
        
        return divider
    }()
    
    private lazy var headerView: UIView = {
        let header = UIView()
        
        header.backgroundColor = UIColor(named: "MainPurpleColor")
        header.layer.cornerRadius = 15
        header.layer.shadowColor = UIColor(named: "GreyButtonColor")?.cgColor
        header.layer.shadowOpacity = 1
        header.layer.shadowRadius = 20
        
        return header
    }()
    
    // MARK: - PUBLIC API

    public weak var delegate: PatientHallViewDelegate?
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setup()
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE
    
    func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        headerView.addSubview(reminderTableView)
        headerView.addSubview(reminderTextField)
        headerView.addSubview(dividerView)
        
        containerView.addSubview(headerView)
        
        addSubview(containerView)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(containerView)
            make.leading.equalTo(containerView)
            make.trailing.equalTo(containerView)
            make.height.equalTo(280)
        }
        
        reminderTableView.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(185)
            make.leading.equalTo(headerView)
            make.trailing.equalTo(headerView)
        }
        
        reminderTextField.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(headerView).offset(16)
            make.trailing.equalTo(headerView).inset(16)
            make.top.equalTo(reminderTableView.snp.bottom).offset(24)
        }

        dividerView.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(2)
            make.width.equalTo(50)
            make.centerX.equalTo(headerView)
            make.top.equalTo(reminderTextField.snp.bottom).offset(10)
        }
    }
    
    private func updateView(with entity: PatientHallViewEntity) {
    }
    
    // MARK: - ACTIONS
    
    func onHandleAddReminder() {
        delegate?.onHandleAddReminder()
    }
}

// MARK: - EXTENSIONS

extension PatientHallView: PatientHallViewType {
    public func updateView(with viewState: PatientHallViewState) {
        switch viewState {
        case .hasData(let entity):
            reminderData = entity.remidersData
        default: break
        }
    }
}

// MARK: - TABLE VIEW IMPLEMENTS

extension PatientHallView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension PatientHallView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reminderData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell") as! ReminderTableViewCell
        cell.reminder = reminderData[indexPath.row]
        
        return cell
    }
}
