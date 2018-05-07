//
//  TimerNotification.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UserNotifications

struct TimerNotification {
    
    private let center: UNUserNotificationCenter
    
    init(_ center: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.center = center
    }
    
    static func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { _, _ in })
    }
    
    func scheduleNotification(_ timeInterval: Double, wihtTitle title: String, withDescription desc: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = desc
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let requestID = String(timeInterval) + "-" + title
        let request = UNNotificationRequest(identifier: requestID, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
    }
}
