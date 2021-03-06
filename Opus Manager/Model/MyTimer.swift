//
//  MyTimer.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 04..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

protocol MyTimerDelegate: class {
    
    func myTimerTimeChanged(_ time: Double, timeString string: String)
    func myTimerStarted(_ time: Double, timeString string: String)
    func myTimerStopped(_ time: Double, timeString string: String)
    func myTimerFinished(_ time: Double, timeString string: String)
}

class MyTimer {
    
    weak var timer: Timer?
    let startTime: Double
    var time: Double
    let accuracy: Double
    
    weak var delegate: MyTimerDelegate?
    
    required init(startTime: Double, time: Double, accuracy: Double = 0.01) {
        self.time = max(time, 0)
        self.startTime = startTime
        self.accuracy = accuracy
    }
    
    var string: String {
        let mins = Int(round(time) / 60)
        let secs = Int(round(time)) % 60
        let minsString = mins > 9 ? String(mins) : String("0\(mins)")
        let secsString = secs > 9 ? String(secs) : String("0\(secs)")
        return  "\(minsString):\(secsString)"
    }
    
    func start() {
        delegate?.myTimerStarted(time, timeString: string)
        if time < 0 {
            return
        }
        startTimer()
    }
    
    private func startTimer() {
        timer?.invalidate()
        let fraction = fractionalTime
        if fraction > accuracy {
            timer = Timer.scheduledTimer(withTimeInterval: fraction, repeats: false, block: { timer in
                self.incrementTimer(withTimeElapsed: fraction)
                self.timer?.invalidate()
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.incementTimer), userInfo: nil, repeats: true)
                self.delegate?.myTimerTimeChanged(self.time, timeString: self.string)
            })
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incementTimer), userInfo: nil, repeats: true)
        }
    }
    
    var fractionalTime: Double {
        let roundedTime = ceil(time)
        return -(time - roundedTime)
    }
    
    @objc private func incementTimer() {
        incrementTimer(withTimeElapsed: 1.0)
        delegate?.myTimerTimeChanged(time, timeString: string)
    }
    
    func incrementTimer(withTimeElapsed elapsed: Double) {
        time = max(0, time + elapsed)
    }
    
    func stop() {
        timer?.invalidate()
        delegate?.myTimerStopped(time, timeString: string)
    }

    func pause() {
        timer?.invalidate()
    }
    
    var timeElapsedSinceStart: Double {
        return time - startTime
    }
    
    func restart(withTimeElapsed elapsed: Double) {
        incrementTimer(withTimeElapsed: elapsed)
        delegate?.myTimerTimeChanged(time, timeString: string)
        if time == 0 {
            return
        }
        startTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
}
