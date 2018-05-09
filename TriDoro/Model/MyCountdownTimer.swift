//
//  MyCountdownTimer.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

class MyCountdownTimer: MyTimer {
    
    let startTime: Double
    
    init(startTime: Double) {
        self.startTime = startTime
        super.init(time: startTime)
    }
    
    override func incrementTimer(withTimeElapsed elapsed: Double) {
        time = max(0, time - elapsed)
    }
    
    override var fractionalTime: Double {
        let roundedTime = floor(time)
        return time - roundedTime
    }
}
