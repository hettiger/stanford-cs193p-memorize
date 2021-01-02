//
//  IdentifiableFake.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 30.12.20.
//

import Foundation

struct IdentifiableFake: Identifiable, Hashable {
    var id = UUID()
}
