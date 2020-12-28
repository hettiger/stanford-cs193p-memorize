//
//  RandomSourceFake.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 28.12.20.
//

import Foundation
import GameKit

class RandomSourceFake: GKRandomSource {
    var shuffle: (([Any]) -> [Any])?
    var lastUpperBound: Int?
    var nextInt = 0
    
    override func arrayByShufflingObjects(in array: [Any]) -> [Any] {
        (shuffle ?? { $0 })(array)
    }
    
    override func nextInt(upperBound: Int) -> Int {
        lastUpperBound = upperBound
        return nextInt
    }
}
