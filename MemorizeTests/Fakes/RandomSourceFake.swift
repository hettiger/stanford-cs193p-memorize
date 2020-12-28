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
    
    override func arrayByShufflingObjects(in array: [Any]) -> [Any] {
        (shuffle ?? { $0 })(array)
    }
}
