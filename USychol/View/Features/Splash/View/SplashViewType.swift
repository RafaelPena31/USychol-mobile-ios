//
//  SplashViewType.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 26/07/21.
//

import UIKit

public protocol SplashViewType: AnyObject {
    var content: UIView { get }
    var delegate: SplashViewDelegate? { get set }
}

extension SplashViewType where Self: UIView {
    public var content: UIView { return self }
}

public protocol SplashViewDelegate: AnyObject {
    func onHandleClick()
}
