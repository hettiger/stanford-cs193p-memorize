//
//  UserDefaultsFake.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 02.01.21.
//

import Foundation

class UserDefaultsFake: UserDefaults {
    override init?(suiteName suitename: String?) {
        super.init(suiteName: suitename ?? #file)
        removePersistentDomain(forName: suitename ?? #file)
    }

    init() {
        super.init(suiteName: #file)!
        removePersistentDomain(forName: #file)
    }
}
