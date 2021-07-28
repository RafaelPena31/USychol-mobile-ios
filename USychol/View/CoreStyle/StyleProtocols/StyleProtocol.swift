//
//  StyleProtocol.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 26/07/21.
//

public protocol Style {
    associatedtype T
    func performStyling(_ object: T)
}

public protocol Stylable {
    func applyStyle<S:Style>(_ style:S) where S.T == Self
}

extension Stylable {
    public func applyStyle<S:Style>(_ style:S) where S.T == Self {
        style.performStyling(self)
    }
}
