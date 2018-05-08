//
//  MyTimer.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 04..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

protocol MyTimerDelegate: class {
    
    func myTimerTimeChanged(_ time: String)
    func myTimerStarted(_ time: String)
    func myTimerFinished(_ time: String)
}

class MyTimer {
    
    weak var timer: Timer?
    var time: Int
    
    weak var delegate: MyTimerDelegate?
    
    init(time: Int = 0) {
        self.time = time
    }
    
    var string: String {
        let mins = time / 60
        let secs = time % 60
        let minsString = mins > 9 ? String(mins) : String("0\(mins)")
        let secsString = secs > 9 ? String(secs) : String("0\(secs)")
        return  "\(minsString):\(secsString)"
    }
    
    func start() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incementTimer), userInfo: nil, repeats: true)
        delegate?.myTimerStarted(string)
    }
    
    @objc func incementTimer() {
        time += 1
        delegate?.myTimerTimeChanged(string)
    }
    
    func stop() {
        timer?.invalidate()
        delegate?.myTimerFinished(string)
    }

    deinit {
        stop()
    }
}
