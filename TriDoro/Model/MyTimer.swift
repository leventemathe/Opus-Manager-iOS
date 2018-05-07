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
    private var startTimestamp: Double?
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
        startTimestamp = Double(Date().timeIntervalSince1970)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incementTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func incementTimer() {
        timestamp += 1
    }
    
    func cancel() {
        timer.invalidate()
    }
    
    func refresh() {
        guard let startTimestamp = startTimestamp else {
            return
        }
        let currentTimestamp = Date().timeIntervalSince1970
        let diff = Int(currentTimestamp - startTimestamp)
        timestamp = diff
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incementTimer), userInfo: nil, repeats: true)
    }
    
    deinit {
        timer.invalidate()
    }
}
