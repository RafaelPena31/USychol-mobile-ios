//
//  CoreLabelType.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 26/07/21.
//

import UIKit

public enum LabelTypeOptions {
    case title
    case text
    case microText
    case cardTitle
    case cardText
    case labelInput
    case divider
    case logo
    case empty
    case select
}

public protocol CoreLabelType: AnyObject {
    var content: UILabel { get }
}

extension CoreLabelType where Self: UILabel {
    public var content: UILabel { return self }
}
