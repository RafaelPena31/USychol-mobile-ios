//
//  CoreHeaderType.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 27/07/21.
//

import UIKit

public enum HeaderTypeOptions {
    case main
    case secondary
}

public protocol CoreHeaderType: AnyObject {
    var content: UILabel { get }
}

extension CoreHeaderType where Self: UILabel {
    public var content: UILabel { return self }
}
