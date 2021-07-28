//
//  GradientStyle.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 22/07/21.
//

import UIKit

enum GradientColorOptions {
    case purple
    case yellow
    case blue
    case green
}

class GradientStyle {
    let currentBound: CGRect
    let currentParentLayer: UIView
    let currentTypeGradientColor: GradientColorOptions
    
    var currentGradientColor: [CGColor] = []
    
    init(bounds: CGRect, color: GradientColorOptions, parentLayer: UIView) {
        currentBound = bounds
        currentParentLayer = parentLayer
        currentTypeGradientColor = color
    }
    
    func setGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = currentBound
        
        switch currentTypeGradientColor {
        case .purple:
            currentGradientColor = [UIColor(named: "MainPurpleColor")!.cgColor, UIColor(named: "PurpleLightColor")!.cgColor]
        case .yellow:
            currentGradientColor = [UIColor(named: "MainYellowColor")!.cgColor, UIColor(named: "YellowLightColor")!.cgColor]
        case .blue:
            currentGradientColor = [UIColor(named: "MainBlueColor")!.cgColor, UIColor(named: "BlueStrongLightColor")!.cgColor]
        case .green:
            currentGradientColor = [UIColor(named: "MainGreenColor")!.cgColor, UIColor(named: "GreenLightColor")!.cgColor]
        }
        
        gradient.colors = currentGradientColor
        
        gradient.locations = [0.5, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.shouldRasterize = true
        
        currentParentLayer.layer.insertSublayer(gradient, at: 0)
    }
}
