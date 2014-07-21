//
//  IGTimer.swift
//  tiemuhr
//
//  Created by Len Smith on 7/18/14.
//  Copyright (c) 2014 Len Smith. All rights reserved.
//

import Foundation

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
        return Int(NSDate().timeIntervalSince1970);
    }
}

class IGTimer {
    var rounds: NSMutableArray
    var roundNumber: Int
    var average: Int
    var clock: IGClockProtocol
    var lastRoundMessage: String

    init(clock:IGClockProtocol) {
        rounds = NSMutableArray()
        self.clock = clock
        roundNumber = 0
        average = 0
        lastRoundMessage = ""
    }

    func getAverage() -> String {
        return secondsToMinutesString(average)
    }

    func increment() -> Int {
        updateLastRoundMessage()
        var round = IGRound(roundNumber: 0, roundStartTime: clock.getTimestamp())
        rounds.addObject(round)
        return 0
    }

    func updateLastRoundMessage() {
        if rounds.count > 0 {
            setLastRoundMessage()
        }

        if rounds.count > 1 {
            setAverage()
        }
    }

    func secondsToMinutesString(seconds: Int) -> String {
        var minutes = seconds/60
        var remainder = seconds%60
        return NSString(format:"%d:%02d", minutes, remainder)
    }

    func setLastRoundMessage() {
        var timeElapsed = clock.getTimestamp() - getLastRound().startTime
        lastRoundMessage = secondsToMinutesString(timeElapsed)
    }

    func setAverage() {
        var timePassed = self.clock.getTimestamp() - getSecondRound().startTime
        println(timePassed)

        self.average = timePassed / (rounds.count - 1)
    }

    func getLastRound() -> IGRound {
        return (rounds.lastObject as IGRound)
    }

    func getSecondRound() -> IGRound {
        return (rounds[1] as IGRound)
    }
}
