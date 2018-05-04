//
//  MyTimer.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 04..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

protocol MyTimerDelegate: class {
    
    func timeChanged()
}

class MyTimer {
    
    private var timer: Timer
    private var timestamp = 0 {
        didSet {
            delegate?.timeChanged()
        }
    }
    
    weak var delegate: MyTimerDelegate?
    
    init(timer: Timer = Timer()) {
        self.timer = timer
    }
    
    var string: String {
        let mins = timestamp / 60
        let secs = timestamp % 60
        let minsString = mins > 9 ? String(mins) : String("0\(mins)")
        let secsString = secs > 9 ? String(secs) : String("0\(secs)")
        return  "\(minsString):\(secsString)"
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incementTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func incementTimer() {
        timestamp += 1
    }
    
    deinit {
        timer.invalidate()
    }
}
