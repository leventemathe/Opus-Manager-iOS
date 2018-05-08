//
//  MyTimerStorage.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

struct MyTimerStorage {
    
    static let START_TIMESTAMP_KEY = "startTimeStamp"
    var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func storeStartTimestamp(_ timestamp: Double = Date().timeIntervalSince1970) {
        userDefaults.set(timestamp, forKey: MyTimerStorage.START_TIMESTAMP_KEY)
    }
    
    func removeStartTimestamp() {
        userDefaults.removeObject(forKey: MyTimerStorage.START_TIMESTAMP_KEY)
    }
    
    func loadStartTimestamp() -> Double? {
        let startTimestampFromUserDefaults = userDefaults.double(forKey: MyTimerStorage.START_TIMESTAMP_KEY)
        if startTimestampFromUserDefaults == 0 {
            return nil
        }
        return startTimestampFromUserDefaults
    }
}
