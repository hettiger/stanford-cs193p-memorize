//
//  UserDefaults+KeysTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 03.01.21.
//

@testable import Memorize
import XCTest

class UserDefaults_KeysTests: XCTestCase {
    func test_userDefaultsReset_removesObjectsFromUserDefaults() {
        let sut = UserDefaultsFake()
        let key = UserDefaults.Key.highscore.rawValue

        sut.set(100, forKey: key)

        XCTAssertEqual(100, sut.integer(forKey: key))

        sut.reset()

        XCTAssertEqual(0, sut.integer(forKey: key))
    }
}
