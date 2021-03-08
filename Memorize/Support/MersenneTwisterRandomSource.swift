//
//  MersenneTwisterRandomSource.swift
//  Memorize
//
//  Created by Martin Hettiger on 03.01.21.
//

import Foundation
import GameKit

protocol RandomSource {
    func randomInt(in range: ClosedRange<Int>) -> Int
    func shuffled<Element>(_ array: [Element]) -> [Element]
}

class MersenneTwisterRandomSource: RandomSource {
    private let randomSource: GKRandomSource

    init(seed: UInt64? = nil) {
        if let seed = seed {
            randomSource = GKMersenneTwisterRandomSource(seed: seed)
        } else {
            randomSource = GKMersenneTwisterRandomSource()
        }
    }

    func randomInt(in range: ClosedRange<Int>) -> Int {
        GKRandomDistribution(
            randomSource: randomSource,
            lowestValue: range.lowerBound,
            highestValue: range.upperBound
        ).nextInt()
    }

    func shuffled<Element>(_ array: [Element]) -> [Element] {
        randomSource.arrayByShufflingObjects(in: array) as! [Element]
    }
}
