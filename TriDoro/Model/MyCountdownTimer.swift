//
//  MyCountdownTimer.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

class MyCountdownTimer: MyTimer {
    
    private var startTime: Int
    
    init(startTime: Int, timer: Timer = Timer()) {
        self.startTime = startTime
        super.init(timer: timer)
        self.timestamp = startTime
    }
    
    override func incementTimer() {
        timestamp -= 1
        if timestamp <= 0 {
            cancel()
        }
    }
    
    override func start() {
        super.start()
        addNotification()
    }
    
    private func addNotification() {
        
    }
    
    func cancelNotification() {
        
    }
}
