//
//  ShortBreakScreenView.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class WorkScreenView: TimerScreenView {
    
    let cancelButton: UIButton = {
        var button = LargeButton()
        button.setText(NSLocalizedString("Cancel", comment: "Label text for cancel button"))
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
    
    private func commonInit() {
        backgroundColor = UIColor.myBackgroundColor
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
