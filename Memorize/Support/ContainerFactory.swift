//
//  ContainerFactory.swift
//  Memorize
//
//  Created by Martin Hettiger on 08.03.21.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct ContainerFactory {
    static func makeMemorizeAppContainer() -> Container {
        let container = Container()

        container.autoregister(RandomSource.self, initializer: MersenneTwisterRandomSource.init)
            .inObjectScope(.container)

        container.register(UserDefaults.self, factory: { _ in UserDefaults.standard })
            .inObjectScope(.container)

        return container
    }
}
