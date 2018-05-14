//
//  ShortBreakVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 14..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

class ShortBreakVC: WorkVC {
    
    override var notificationTitle: String { return NSLocalizedString("Break over!", comment: "") }
    override var notificationDescription: String { return NSLocalizedString("Time for some work.", comment: "") }
}
