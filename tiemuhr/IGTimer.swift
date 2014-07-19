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
        return 0;
    }
}


class IGTimer {
    var rounds: NSMutableArray
    var roundNumber: Int
    var clock: IGClockProtocol
    var lastRoundMessage: String

    init(clock:IGClockProtocol) {
        rounds = NSMutableArray()
        self.clock = clock
        roundNumber = 0
        lastRoundMessage = ""
    }

    func increment() -> Int {
        updateLastRoundMessage()

        var round = IGRound(roundNumber: 0, roundStartTime: clock.getTimestamp())
        rounds.addObject(round)

        return 0
    }

    func updateLastRoundMessage() {
        if rounds.count > 0 {
            var timeElapsed = clock.getTimestamp() - getLastRound().startTime
            println(timeElapsed)
            println("-------------------------------------------------")

            lastRoundMessage = "\(timeElapsed) Seconds"
            println(self.lastRoundMessage)
        }
    }

    func getLastRound() -> IGRound {
        return (rounds.lastObject as IGRound)
    }
}
