//
//  PatientReportViewState.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public enum PatientReportViewState: Equatable {
    case hasData(PatientReportViewEntity)
    case isEmpty
}
