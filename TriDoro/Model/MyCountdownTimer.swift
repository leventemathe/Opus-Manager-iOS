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
        addNotification()
    }
    
    override func refresh() {
        guard let diff = diff else {
            return
        }
        time = startTime - diff
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incementTimer), userInfo: nil, repeats: true)
    }
    
    private func addNotification() {
        
    }
    
    func cancelNotification() {
        
    }
}
