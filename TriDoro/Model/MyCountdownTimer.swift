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
    
    init(startTime: Int) {
        self.startTime = startTime
        super.init(time: startTime)
    }
    
    override func incementTimer() {
        let newTime = time - 1
        if newTime >= 0 {
            time = newTime
        } else {
            stop()
        }
        delegate?.myTimerTimeChanged(string)
    }
    
    override func restart(withTimeElapsed elapsed: Int) {
        time = max(0, time - elapsed)
        if time == 0 {
            return
        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incementTimer), userInfo: nil, repeats: true)
    }
}
