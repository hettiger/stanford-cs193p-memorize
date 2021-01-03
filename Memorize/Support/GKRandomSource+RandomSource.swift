//
//  GKRandomSource+RandomSource.swift
//  Memorize
//
//  Created by Martin Hettiger on 03.01.21.
//

import Foundation
import GameKit

protocol RandomSource {
    func randomInt(in range: ClosedRange<Int>) -> Int
    func shuffled<T>(_ array: [T]) -> [T]
}

extension GKRandomSource: RandomSource {
    func randomInt(in range: ClosedRange<Int>) -> Int {
        nextInt(upperBound: range.upperBound + 1 - range.lowerBound) + range.lowerBound
    }

    func shuffled<Element>(_ array: [Element]) -> [Element] {
        arrayByShufflingObjects(in: array) as! [Element]
    }
}
