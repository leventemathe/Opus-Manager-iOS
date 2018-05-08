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
        time -= 1
        delegate?.myTimerTimeChanged(string)
        if time <= 0 {
            stop()
        }
    }
}
