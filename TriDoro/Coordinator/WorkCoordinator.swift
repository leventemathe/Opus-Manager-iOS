//
//  WorkCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class WorkCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var coordinators = [String : Coordinator]()
    
    let startTime: Double
    let animated: Bool
    
    init(navigationController: UINavigationController, startTime: Double, animated: Bool) {
        self.navigationController = navigationController
        self.startTime = startTime
        self.animated = animated
    }
    
    func start() {
        let workVC = WorkVC()
        workVC.timerModel = MyCountdownTimer(startTime: startTime)
        workVC.timerStorage = MyTimerStorage()
        workVC.notifications = TimerNotification()
        workVC.delegate = self
        navigationController.pushViewController(workVC, animated: animated)
    }
}

extension WorkCoordinator: TimerVCDelegate {
    
    func done() {
        navigationController.popViewController(animated: animated)
    }
}
