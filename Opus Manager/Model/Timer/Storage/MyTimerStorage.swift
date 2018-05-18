//
//  MyTimerStorage.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

struct MyTimerStorageKeys {
    static let WORK = "work"
    static let SHORT_BREAK = "short_break"
    static let LONG_BREAK = "long_break"
}

protocol MyTimerStorage {
    
    var key: String { get }
    var userDefaults: UserDefaults { get }
    
    func store(startTimestamp timestamp: Double)
    func removeStartTimestamp()
    func loadStartTimestamp() -> Double?
}

extension MyTimerStorage {
    
    func store(startTimestamp timestamp: Double) {
        userDefaults.set(timestamp, forKey: key)
    }
    
    func removeStartTimestamp() {
        userDefaults.removeObject(forKey: key)
    }
    
    func loadStartTimestamp() -> Double? {
        let startTimestampFromUserDefaults = userDefaults.double(forKey: key)
        if startTimestampFromUserDefaults == 0 {
            return nil
        }
        return startTimestampFromUserDefaults
    }
}
