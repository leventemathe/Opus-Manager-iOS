//
//  MyCountdownTimer.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

class MyCountdownTimer: MyTimer {
    
    override func incrementTimer(withTimeElapsed elapsed: Double) {
        time = max(0, time - elapsed)
        if abs(time) < accuracy {
            delegate?.myTimerFinished(time, timeString: string)
        }
    }
    
    override var fractionalTime: Double {
        let roundedTime = floor(time)
        return time - roundedTime
    }
    
    override var timeElapsedSinceStart: Double {
        return startTime - time
    }
}
