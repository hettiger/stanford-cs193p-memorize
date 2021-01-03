//
//  Int+randomUsing.swift
//  Memorize
//
//  Created by Martin Hettiger on 28.12.20.
//

import Foundation
import GameKit

extension Int {
    static func random(in range: ClosedRange<Int>, using randomSource: RandomSource) -> Int {
        randomSource.randomInt(in: range)
    }
}
