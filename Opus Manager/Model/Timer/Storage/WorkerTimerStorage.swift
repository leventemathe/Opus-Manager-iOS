//
//  WorkerTimerStorage.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 07..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

class WorkerTimerStorage: MyTimerStorage {
    let key: String
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        key = MyTimerStorageKeys.WORK
    }
}
