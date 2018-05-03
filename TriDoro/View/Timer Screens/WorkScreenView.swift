//
//  ShortBreakScreenView.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class WorkScreenView: TimerScreenView {
    
    override func commonInit() {
        super.commonInit()
        doneButton.setText(NSLocalizedString("Cancel", comment: "Label text for cancel button"))
    }
}
