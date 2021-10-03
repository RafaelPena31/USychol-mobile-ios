//
//  PatientHallView.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 29/07/21.
//
//

import UIKit
import SnapKit

final public class PatientHallView: UIView {
    
    // MARK: - PROPERTIES
    
    var reminderData: [Reminder] = []
    var patientData: [Patient] = []
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "WhiteColor")
        
        return view
    }()
    
//    =======================================================
    
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
        
        header.layer.shadowColor = UIColor(named: "NeonBlackColor")?.cgColor
        header.layer.shadowOpacity = 0.5
        header.layer.shadowRadius = 10
        header.layer.cornerRadius = 15
        header.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        return header
    }()
    
//    =======================================================
    
    private lazy var patientTableView: PatientTableView = {
        let tableView = PatientTableView()
        
        tableView.register(PatientTableViewCell.self, forCellReuseIdentifier: "patientCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
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
        headerView.addSubview(reminderTextField)
        headerView.addSubview(dividerView)
        headerView.addSubview(reminderTableView)
        
        containerView.addSubview(headerView)
        containerView.addSubview(patientTableView)
        
        addSubview(containerView)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(280)
        }
        
        reminderTableView.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(185)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
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
        
        patientTableView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    private func updateView(with entity: PatientHallViewEntity) {
    }
    
    // MARK: - ACTIONS
    
    func onHandleAddReminder(_ text: String) {
        if text.isEmpty {
            delegate?.onHandleErrorAlert()
        } else {
            delegate?.onHandleAddReminder(text)
            reminderTextField.text = ""
        }
    }
}

// MARK: - EXTENSIONS

extension PatientHallView: PatientHallViewType {
    public func updateView(with viewState: PatientHallViewState) {
        switch viewState {
        case .hasData(let entity):
            reminderData = entity.remidersData
            patientData = entity.patientsData
        default: break
        }
    }
}

// MARK: - TABLE VIEW IMPLEMENTS

extension PatientHallView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == reminderTableView {
            return 65
        }
        return 90
    }
}

extension PatientHallView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == reminderTableView {
            let reminderCount = reminderData.count
            
            if reminderCount > 0 {
                tableView.restoreBackgroundView()
            }
            
            return reminderCount
        }
        
        let patientCount = patientData.count
        
        if patientCount > 0 {
            tableView.restoreBackgroundView()
        }
        
        return patientCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == reminderTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell") as! ReminderTableViewCell
            cell.reminder = reminderData[indexPath.row]
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "patientCell") as! PatientTableViewCell
        cell.patients = patientData[indexPath.row]
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView != reminderTableView {
            let patient = patientData[indexPath.row]
            delegate?.onHandlePatientProfileRedirect(patient: patient)
        }
    }
}

extension PatientHallView: PatientHallViewControllerViewDelegate {
    public func reloadData() {
        patientTableView.reloadData()
        reminderTableView.reloadData()
    }
}
