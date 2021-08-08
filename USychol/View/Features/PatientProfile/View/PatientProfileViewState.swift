//
//  PatientProfileViewState.swift
//  USychol
//
//  Created Rafael Augusto Mesquita on 08/08/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

public enum PatientProfileViewState: Equatable {
    case hasData(PatientProfileViewEntity)
    case isEmpty
}
