//
//  WorkCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class WorkCoordinator: TimerCoordinator<WorkVC, MyCountdownTimer> {
 
    override func start() {
        super.start()
        if let workVC = navigationController.topViewController as? WorkVC {
            workVC.workSessionCounter = WorkSessionCounter()
        }
    }
}
