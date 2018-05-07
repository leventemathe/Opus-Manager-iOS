//
//  MyTimer.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 04..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

protocol MyTimerDelegate: class {
    
    func timeChanged(_ time: String)
}

class MyTimer {
    
    var timer: Timer
    
    var time = 0 {
        didSet {
            delegate?.timeChanged(string)
        }
    }
    
    private var myTimerStorage: MyTimerStorage
    
    weak var delegate: MyTimerDelegate?
    
    init(timer: Timer = Timer(), myTimerStorage: MyTimerStorage = MyTimerStorage()) {
        self.timer = timer
        self.myTimerStorage = myTimerStorage
    }
    
    var string: String {
        let mins = time / 60
        let secs = time % 60
        let minsString = mins > 9 ? String(mins) : String("0\(mins)")
        let secsString = secs > 9 ? String(secs) : String("0\(secs)")
        return  "\(minsString):\(secsString)"
    }
    
    func start() {
        let startTimestamp = Double(Date().timeIntervalSince1970)
        myTimerStorage.store(startTimestamp: startTimestamp)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incementTimer), userInfo: nil, repeats: true)
        delegate?.timeChanged(string)
    }
    
    @objc func incementTimer() {
        time += 1
    }
    
    func pauseBecauseAppBecomesInactive() {
        timer.invalidate()
    }
    
    func cancel() {
        timer.invalidate()
        myTimerStorage.removeStartTimestamp()
    }    
    
    var diff: Int? {
        guard let startTimestamp = myTimerStorage.loadStartTimestamp() else {
            return nil
        }
        let currentTimestamp = Date().timeIntervalSince1970
        return Int(currentTimestamp - startTimestamp)
    }
    
    func refreshBecauseAppBecomesActive() {
        guard let diff = diff else {
            return
        }
        time = diff
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incementTimer), userInfo: nil, repeats: true)
    }
    
    deinit {
        timer.invalidate()
    }
}
