//
//  TimerLabel.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class TimerLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    private func commonInit() {
        font = UIFont.myDisplayLight
        textColor = UIColor.myTintColor
    }
    
    private var timestamp = 0 {
        didSet {
            setText()
        }
    }
    
    private func setText() {
        let mins = timestamp / 60
        let secs = timestamp % 60
        text = "\(mins):\(secs)"
    }
    
    func setTime(_ timestamp: Int) {
        self.timestamp = timestamp
    }
    
    func increment() {
        timestamp += 1
    }
    
    func decrement() {
        timestamp -= 1
    }
}
