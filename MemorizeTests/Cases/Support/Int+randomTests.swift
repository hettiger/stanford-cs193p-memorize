//
//  Int+randomTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 28.12.20.
//

@testable import Memorize
import XCTest

class Int_randomTests: XCTestCase {
    var randomSourceFake: RandomSourceFake!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        randomSourceFake = RandomSourceFake()
    }
    
    override func tearDownWithError() throws {
        randomSourceFake = nil
        try super.tearDownWithError()
    }
    
    func test_intRandomInUsing_returnsRandomIntInClosedRange() {
        let lowerBound = 2
        let upperBound = 5
        let expectedRandomSourceUpperBound = upperBound - lowerBound + 1
        
        for nextInt in 0..<expectedRandomSourceUpperBound {
            let expectedInt = nextInt + lowerBound
            randomSourceFake.nextInt = nextInt
            
            let actualInt = Int.random(in: 2...5, using: randomSourceFake)
            
            XCTAssertEqual(expectedRandomSourceUpperBound, randomSourceFake.lastUpperBound)
            XCTAssertEqual(expectedInt, actualInt)
        }
    }
}
