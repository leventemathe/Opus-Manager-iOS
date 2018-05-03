//
//  WorkVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class WorkVC: TimerVC {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.setText(NSLocalizedString("Cancel", comment: "Label text for cancel button"))
    }
}
