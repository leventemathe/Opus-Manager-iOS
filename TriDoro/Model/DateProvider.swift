//
//  DateProvider.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 14..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

struct DateProvider {
    
    func noon(_ date: Date = Date()) -> Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: date)!
    }
    
    func yesterday(_ date: Date = Date()) -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon())!
    }
    
    func isDateYesterday(_ date: Date) -> Bool {
        let todayNoon = noon()
        let noonFromDate = noon(date)
        return todayNoon > noonFromDate
    }
}
