//
//  tiemuhrTests.swift
//  tiemuhrTests
//
//  Created by Len Smith on 7/14/14.
//  Copyright (c) 2014 Len Smith. All rights reserved.
//

import XCTest


class MockClock: IGClockProtocol {
    var stubbedTime:Int

    func nextTime(timeToStub: Int) {
        stubbedTime = timeToStub
    }

    init() {
        stubbedTime = 0
    }

    func getTimestamp() -> Int {
        return stubbedTime
    }
}


class tiemuhrTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHasAnArrayOfRounds() {
        var clock =  MockClock()        
        var timer = IGTimer(clock: clock)
        XCTAssertEqual(timer.rounds.count, 0)
    }

    func testCanIncrementRounds() {
        var clock =  MockClock()
        var timer = IGTimer(clock: clock)
        clock.nextTime(9)
        timer.increment()
        XCTAssertEqual(timer.rounds.count, 1)
        XCTAssertEqual((timer.rounds[0] as IGRound).startTime, 9)
    }

    func testCanGetRoundMessage() {
        var clock =  MockClock()
        var timer = IGTimer(clock: clock)
        clock.nextTime(0)
        timer.increment()
        clock.nextTime(20)
        timer.increment()

        XCTAssertEqual(timer.lastRoundMessage, "20 Seconds")
        clock.nextTime(30)
        timer.increment()
        XCTAssertEqual(timer.lastRoundMessage, "10 Seconds")
    }
}
