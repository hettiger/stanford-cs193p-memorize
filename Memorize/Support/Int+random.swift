//
//  Int+randomUsing.swift
//  Memorize
//
//  Created by Martin Hettiger on 28.12.20.
//

import Foundation
import GameKit

extension Int {
    static func random(in range: ClosedRange<Int>, using randomSource: GKRandom) -> Int {
        let bounds = (lower: range.lowerBound, upper: range.upperBound)
        return randomSource.nextInt(upperBound: bounds.upper + 1 - bounds.lower) + bounds.lower
    }
}
