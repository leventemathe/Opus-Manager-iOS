//
//  TimerScreenView.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class TimerScreenView: UIView {
        
    let doneButton: LargeButton = {
        var button = LargeButton()
        button.setText(NSLocalizedString("Done", comment: "Label text for done button"))
        return button
    }()
    
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
    
    func commonInit() {
        backgroundColor = UIColor.myBackgroundColor
        addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
