//
//  PatientHallViewState.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 29/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public enum PatientHallViewState: Equatable {
    case hasData(PatientHallViewEntity)
    case isEmpty
}
