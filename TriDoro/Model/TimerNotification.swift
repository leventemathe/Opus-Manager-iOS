//
//  TimerNotification.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UserNotifications

class TimerNotification: NSObject, UNUserNotificationCenterDelegate {
    
    private let center: UNUserNotificationCenter
    
    init(_ center: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.center = center
        super.init()
        self.center.delegate = self
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
        self.removeAllNotifications()
        center.add(request, withCompletionHandler: { _ in })
    }
    
    func removeAllNotifications() {
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
