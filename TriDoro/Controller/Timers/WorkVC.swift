//
//  WorkVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class WorkVC: TimerVC {
    
    var notifications: TimerNotification!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.setText(NSLocalizedString("Cancel", comment: "Label text for cancel button"))
    }
    
    // The notifications are removed here, instead of myTimerFinished, because the timer may be a little faster then the notification
    override func done() {        
        notifications.removeAllNotifications()
        super.done()
    }

    override func myTimerStarted(_ time: String) {
        super.myTimerStarted(time)
        notifications.removeAllNotifications()
        let title = NSLocalizedString("Work Done!", comment: "")
        let desc = NSLocalizedString("Time for a break.", comment: "")
        notifications.scheduleNotification(Double(timerModel.time), wihtTitle: title, withDescription: desc)
    }
}
