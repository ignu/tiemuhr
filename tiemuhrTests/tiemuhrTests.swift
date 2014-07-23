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

    func passTime(timer : IGTimer, seconds: Int) {
        (timer.clock as MockClock).nextTime(seconds)
        timer.increment()
    }

    func testCanGetRoundMessage() {
        var clock =  MockClock()
        var timer = IGTimer(clock: clock)
        passTime(timer, seconds: 0)  // ignore first round
        XCTAssertEqual(timer.lastRoundMessage, "")
        passTime(timer, seconds: 20)
        XCTAssertEqual(timer.lastRoundMessage, "0:20")
        passTime(timer, seconds: 89)
        XCTAssertEqual(timer.lastRoundMessage, "1:09")
    }
    
    func testAverageAvailable() {
        var clock =  MockClock()
        var timer = IGTimer(clock: clock)
        passTime(timer, seconds: 0)
        XCTAssertFalse(timer.averageAvailable())
        passTime(timer, seconds: 0)
        XCTAssertTrue(timer.averageAvailable())
    }

    func testGetRoundAverage() {
        var clock =  MockClock()
        var timer = IGTimer(clock: clock)
        passTime(timer, seconds: 0)
        passTime(timer, seconds: 20) // doesnt count
        passTime(timer, seconds: 40) // 20
        passTime(timer, seconds: 50) // 10
        XCTAssertEqual(timer.average, 15)
    }
}
