//
//  +Array.swift
//  USychol
//
//  Created by Rafael Augusto Mesquita on 14/11/21.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
