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
    
    override func startTimer() {
        super.startTimer()
        if let timer = timerModel as? MyCountdownTimer {
            let notificationTitle = NSLocalizedString("Work done!", comment: "The notification title for work done")
            let notificationDescription = NSLocalizedString("Congrats! Now enjoy a short break (if you want).", comment: "The notification title for work done")
            notifications.scheduleNotification(3, wihtTitle: notificationTitle, withDescription: notificationDescription)
        }
    }
    
    override func done() {
        notifications.removeAllNotifications()
        super.done()
    }
}
