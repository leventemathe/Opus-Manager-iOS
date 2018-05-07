//
//  TimerNotification.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UserNotifications

struct TimerNotification {
    
    private let center = UNUserNotificationCenter.current()
    
    static func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { _, _ in })
    }
}
