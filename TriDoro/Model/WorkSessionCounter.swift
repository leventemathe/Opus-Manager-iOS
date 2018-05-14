//
//  WorkSessionCounter.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 14..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

struct WorkSessionCounter {
    
    private let WORK_SESSIONS_TODAY_COUNT = "work_sessions_today_count"
    private let WORK_SESSIONS_TODAY_DATE = "work_sessions_today_date"
    
    private let userDefaults: UserDefaults
    private let dateProvider: DateProvider
    
    init(userDefaults: UserDefaults = UserDefaults.standard, dateProvider: DateProvider = DateProvider()) {
        self.userDefaults = userDefaults
        self.dateProvider = dateProvider
    }
    
    func add() {
        if shouldReset {
            reset()
            userDefaults.set(1, forKey: WORK_SESSIONS_TODAY_COUNT)
        } else {
            let current = userDefaults.integer(forKey: WORK_SESSIONS_TODAY_COUNT)
            userDefaults.set(current+1, forKey: WORK_SESSIONS_TODAY_COUNT)
        }
    }
    
    private var shouldReset: Bool {
        let currentTimestamp = userDefaults.double(forKey: WORK_SESSIONS_TODAY_DATE)
        if currentTimestamp == 0 {
            return false
        }
        return dateProvider.isDateYesterday(Date(timeIntervalSince1970: currentTimestamp))
    }
    
    private func reset() {
        userDefaults.set(dateProvider.noon().timeIntervalSince1970, forKey: WORK_SESSIONS_TODAY_DATE)
        userDefaults.set(0, forKey: WORK_SESSIONS_TODAY_COUNT)
    }
    
    func load() -> Int {
        if shouldReset {
            reset()
            return 0
        }
        return userDefaults.integer(forKey: WORK_SESSIONS_TODAY_COUNT)
    }
}
