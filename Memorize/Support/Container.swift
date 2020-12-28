//
//  Container.swift
//  Memorize
//
//  Created by Martin Hettiger on 28.12.20.
//

import Foundation
import GameKit

class Container {
    static var shared = Container()

    lazy var randomSource: GKRandomSource = GKMersenneTwisterRandomSource()
}
