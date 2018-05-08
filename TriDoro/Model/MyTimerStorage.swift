//
//  MyTimerStorage.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

typealias TimerNameAndStartTimestamp = [String: Double]

struct MyTimerStorage {
    
    static let TIMER_IN_PROGRESS = "timer_in_progress"
    
    var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func storeTimer(_ timer: String, withStartTimestamp timestamp: Double = Date().timeIntervalSince1970) {
        userDefaults.set([timer: timestamp], forKey: MyTimerStorage.TIMER_IN_PROGRESS)
    }
    
    func removeTimer() {
        userDefaults.removeObject(forKey: MyTimerStorage.TIMER_IN_PROGRESS)
    }
    
    func loadTimer() -> TimerNameAndStartTimestamp? {
        if let timer = userDefaults.object(forKey: MyTimerStorage.TIMER_IN_PROGRESS) as? TimerNameAndStartTimestamp {
            return timer
        }
        return nil
    }
}
