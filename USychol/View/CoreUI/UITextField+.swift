//
//  UITextField+.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 07/08/21.
//

import UIKit

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
