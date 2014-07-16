//
//  tiemuhrTests.swift
//  tiemuhrTests
//
//  Created by Len Smith on 7/14/14.
//  Copyright (c) 2014 Len Smith. All rights reserved.
//

import XCTest

class IGRound {
    var number:Int
    var startTime:Int

    init(roundNumber:Int, roundStartTime:Int) {
        number = roundNumber
        startTime = roundStartTime
    }
}


protocol IGClockProtocol {
    func getTimestamp() -> Int
}

class IGClock: IGClockProtocol {
    func getTimestamp() -> Int {
        return 0;
    }
}

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

class IGTimer {
    var rounds: NSMutableArray
    var roundNumber: Int
    var clock: IGClockProtocol

    init(clock:IGClockProtocol) {
        rounds = NSMutableArray()
        self.clock = clock
        roundNumber = 0
    }

    func increment() -> Int {
        var round = IGRound(roundNumber: 0, roundStartTime: clock.getTimestamp())
        rounds.addObject(round)
        return 0
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
        XCTAssertEqual(timer.rounds.count, 0)
        timer.increment()
        XCTAssertEqual(timer.rounds.count, 1)
        XCTAssertEqual((timer.rounds[1] as IGRound).startTime, 9)
    }
}
