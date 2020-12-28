//
//  Array+shuffle.swift
//  Memorize
//
//  Created by Martin Hettiger on 28.12.20.
//

import Foundation
import GameKit

extension Array {
    mutating func shuffle(using randomSource: GKRandomSource) {
        self = randomSource.arrayByShufflingObjects(in: self as [Any]) as! [Element]
    }
}
