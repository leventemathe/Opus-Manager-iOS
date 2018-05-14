//
//  CountdownTimerVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 14..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class CountdownTimerVC: TimerVC {
    
    let circleView = CircleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if abs(timerModel.time) < timerModel.accuracy {
            doneButton.setText(NSLocalizedString("Done", comment: "Label text for done button"))
        } else {
            doneButton.setText(NSLocalizedString("Cancel", comment: "Label text for cancel button"))
        }
        
    }
    
    override func setupView() {
        setupBackground()
        setupCircleView()
        setupTimerLabel()
        setupDoneButton()
    }
    
    private func setupCircleView() {
        view.addSubview(circleView)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let size: CGFloat = 260
        circleView.widthAnchor.constraint(equalToConstant: size).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    override func setupDoneButton() {
        view.addSubview(doneButton)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 32).isActive = true
        
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    
    // The notifications are removed here, instead of myTimerFinished, because the timer may be a little faster then the notification
    override func done() {
        notifications.removeAllNotifications()
        super.done()
    }
    
    override func myTimerStarted(_ time: Double, timeString string: String) {
        super.myTimerStarted(time, timeString: string)
        createNotification()
        refreshCircleView()
    }
    
    var notificationTitle: String { return NSLocalizedString("Done!", comment: "") }
    var notificationDescription: String { return NSLocalizedString("", comment: "") }
    
    private func createNotification() {
        notifications.removeAllNotifications()
        notifications.scheduleNotification(Double(timerModel.time), wihtTitle: notificationTitle, withDescription: notificationDescription)
    }
    
    private func refreshCircleView() {
        if abs(timerModel.time) < timerModel.accuracy {
            circleView.percent = 0
        } else {
            circleView.percent = timerModel.time / timerModel.startTime
        }
    }
    
    override func myTimerTimeChanged(_ time: Double, timeString string: String) {
        super.myTimerTimeChanged(time, timeString: string)
        refreshCircleView()
    }
    
    override func myTimerFinished(_ time: Double, timeString string: String) {
        super.myTimerFinished(time, timeString: string)
        doneButton.setText(NSLocalizedString("Done", comment: "Label text for done button"))
    }
}
