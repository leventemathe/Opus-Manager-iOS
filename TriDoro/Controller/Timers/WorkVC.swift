//
//  WorkVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class WorkVC: CountdownTimerVC {
    
    override var notificationTitle: String { return NSLocalizedString("Work done!", comment: "") }
    override var notificationDescription: String { return NSLocalizedString("Time for some break.", comment: "") }
    
    var workSessionCounter: WorkSessionCounter!
    
    override func myTimerFinished(_ time: Double, timeString string: String) {
        super.myTimerFinished(time, timeString: string)
        workSessionCounter.add()
    }
}
