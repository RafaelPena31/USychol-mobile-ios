//
//  LabelStyle.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 26/07/21.
//
import UIKit

extension UILabel:Stylable {}

public struct LabelStyle:Style {

    let textColor:UIColor
    let font:UIFont

    public func performStyling(_ object: UILabel){
        object.textColor = textColor
        object.font = font
    }
    
    public var defaultStyle: LabelStyle {
        return LabelStyle(textColor: UIColor.black, font: UIFont.systemFont(ofSize: 15))
    }

    public var boldStyle: LabelStyle {
        return LabelStyle(textColor: UIColor.black, font: UIFont.boldSystemFont(ofSize: 15))
    }
    
    public var italicStyle: LabelStyle {
        return LabelStyle(textColor: UIColor.black, font: UIFont.italicSystemFont(ofSize: 15))
    }
}
