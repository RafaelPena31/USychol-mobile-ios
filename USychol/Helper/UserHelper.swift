//
//  UserHelper.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 13/08/21.
//

class UserHelper {
    public func getPlansByPlans(_ type: Plans?) -> String? {
        switch type {
        case .virtual:
            return "Virtual"
        case .digital:
            return "Digital"
        case .full:
            return "Full"
        default:
            return nil
        }
    }
    
    public func getPlansByString(_ type: String?) -> Plans? {
        switch type {
        case "Virtual":
            return .virtual
        case "Digital":
            return .digital
        case "Full":
            return .full
        default:
            return nil
        }
    }
}
