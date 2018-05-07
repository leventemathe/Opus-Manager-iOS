//
//  TimerLabel.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class TimerLabel: UILabel, MyTimerDelegate {
    
    private override init(frame: CGRect) {
        self.timer = MyTimer()
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.timer = MyTimer()
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init(timer: MyTimer = MyTimer()) {
        self.timer = timer
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    var timer: MyTimer
    
    private func commonInit() {
        timer.delegate = self
        font = UIFont.myDisplayLight
        textColor = UIColor.myTintColor
        text = timer.string
    }
    
    func start() {
        timer.start()
    }
    
    func cancel() {
        timer.cancel()
    }
    
    func refresh() {
        timer.refresh()
    }
    
    func timeChanged() {
        text = timer.string
    }
}
