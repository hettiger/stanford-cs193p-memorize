//
//  RandomSourceFake.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 28.12.20.
//

import Foundation
import GameKit
@testable import Memorize

class RandomSourceFake: RandomSource {
    var shuffle: (([Any]) -> [Any])?
    var lastRange: ClosedRange<Int>?
    var nextInt = 0

    func randomInt(in range: ClosedRange<Int>) -> Int {
        lastRange = range
        return nextInt
    }

    func shuffled<T>(_ array: [T]) -> [T] {
        (shuffle ?? { $0 })(array) as! [T]
    }
}
