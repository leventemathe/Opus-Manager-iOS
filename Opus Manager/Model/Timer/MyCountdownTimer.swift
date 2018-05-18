//
//  MyCountdownTimer.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

class MyCountdownTimer: MyTimer {
    
    let startTime: Int
    
    init(startTime: Int, myTimerStorage: MyTimerStorage, timer: Timer = Timer()) {
        self.startTime = startTime
        super.init(myTimerStorage: myTimerStorage, timer: timer)
        self.time = startTime
    }
    
    override func incementTimer() {
        time -= 1
        if time <= 0 {
            cancel()
        }
    }
    
    override func start() {
        super.start()
    }
    
    override func refreshBecauseAppBecomesActive() {
        guard let diff = diff else {
            return
        }
        time = max(startTime - diff, 0)
        if time <= 0 {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incementTimer), userInfo: nil, repeats: true)
    }
}
