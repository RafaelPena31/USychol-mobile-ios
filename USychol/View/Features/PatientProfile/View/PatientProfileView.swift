//
//  PatientProfileView.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

final public class PatientProfileView: UIView {
    
    // MARK: - PROPERTIES
    
    var reportsData: [Report] = []
    var patientData: Patient?
    
    let mockSummaryData = "The patient demonstrates hyperactivity and loss of focus in their daily tasks. He reported feelings of loneliness and longing for his parents for having gone to live at the school at an early age."
    
    // MARK: - UI
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), placeholder: "Search report", onHandleClickAdd: onHandleSearchReport)
        
        return textField
    }()
    
    private lazy var reportTableView: ReportTableView = {
        let tableView = ReportTableView()
        
        tableView.register(ReportTableViewCell.self, forCellReuseIdentifier: "reportCell")
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
        header.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        header.layer.shadowColor = UIColor(named: "NeonBlackColor")?.cgColor
        header.layer.shadowOpacity = 0.5
        header.layer.shadowRadius = 10
        
        return header
    }()
    
    private lazy var patientSummaryTitle: CoreLabel = {
        let label = CoreLabel(type: .divider, text: "Patient Summary", color: "NeonBlackColor")
        
        return label
    }()
    
    private lazy var patientSummaryDescription: CoreLabel = {
        let label = CoreLabel(type: .cardTitle, text: patientData?.patientSummary ?? mockSummaryData, color: "NeonStrongLightColor")
        
        label.numberOfLines = 0
        label.textAlignment = .justified
        
        return label
    }()
    
    private lazy var patientSummaryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [patientSummaryTitle, patientSummaryDescription])
        
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        
        return stack
    }()
    
    private lazy var accessAnamnesisButton: CoreRedirectButton = {
        let button = CoreRedirectButton(leftIconName: "paper-icon", title: "Access Anamnesis", onPressMethod: onHandleAccessAnamnesis)
        
        return button
    }()
    
    private lazy var createActivyButton: CoreRedirectButton = {
        let button = CoreRedirectButton(leftIconName: "plus-icon", title: "Create new activity", onPressMethod: onHandleCreateActivy)
        
        return button
    }()
    
    private lazy var createReportButton: CoreRedirectButton = {
        let button = CoreRedirectButton(leftIconName: "list-icon", title: "Create new report", onPressMethod: onHandleCreateReport)
        
        return button
    }()
    
    private lazy var redirectButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [accessAnamnesisButton, createActivyButton, createReportButton])
        
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 16
        
        return stack
    }()
    
    // MARK: - PUBLIC API

    public weak var delegate: PatientProfileViewDelegate?
    
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
        headerView.addSubview(searchTextField)
        headerView.addSubview(reportTableView)
        headerView.addSubview(dividerView)
        
        containerView.addSubview(headerView)
        containerView.addSubview(patientSummaryStack)
        containerView.addSubview(redirectButtonStack)
        
        self.addSubview(containerView)
    }
    
    private func addConstraints() {
        containerView.snp.makeConstraints {(make) -> Void in
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        headerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(300)
        }
        
        searchTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(24)
            make.leading.equalTo(headerView).offset(16)
            make.trailing.equalTo(headerView).inset(16)
        }
        
        reportTableView.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(185)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.top.equalTo(searchTextField.snp.bottom).offset(24)
        }

        dividerView.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(2)
            make.width.equalTo(50)
            make.centerX.equalTo(headerView)
            make.top.equalTo(reportTableView.snp.bottom).offset(10)
        }
        
        patientSummaryStack.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(headerView.snp.bottom).offset(24)
            make.leading.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView).inset(16)
        }
        
        accessAnamnesisButton.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(50)
            make.leading.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView).inset(16)
        }
        
        createActivyButton.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(50)
            make.leading.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView).inset(16)
        }
        
        createReportButton.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(50)
            make.leading.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView).inset(16)
        }
        
        redirectButtonStack.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(containerView).inset(24)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
        }
    }
    
    private func updateView(with entity: PatientProfileViewEntity) {
        
    }
    
    // MARK: - ACTIONS
    
    func onHandleAccessReport() {
        delegate?.onHandleAccessReport()
    }
    
    func onHandleSearchReport() {
        delegate?.onHandleSearchReport()
    }
    
    func onHandleAccessAnamnesis() {
        delegate?.onHandleAccessAnamnesis()
    }
    
    func onHandleCreateActivy() {
        delegate?.onHandleCreateActivy()
    }
    
    func onHandleCreateReport() {
        delegate?.onHandleCreateReport()
    }
}

extension PatientProfileView: PatientProfileViewType {
    public func updateView(with viewState: PatientProfileViewState) {
        switch viewState {
        case .hasData(let entity):
            reportsData = entity.reportsData
            patientData = entity.patient
        default: break
        }
    }
}

// MARK: - TABLE VIEW IMPLEMENTS

extension PatientProfileView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension PatientProfileView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reportsData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell") as! ReportTableViewCell
        let patientProfilePic = patientData?.profilePicture
        
        cell.patientProfilePic = patientProfilePic
        cell.reports = reportsData[indexPath.row]
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onHandleAccessReport()
    }
}
