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
    var image: UIImage?
    
    init(navigationController: UINavigationController, startTime: Double, animated: Bool, image: UIImage?) {
        self.navigationController = navigationController
        self.startTime = startTime
        self.animated = animated
        self.image = image
    }
    
    func start() {
        let workVC = WorkVC()
        workVC.timerModel = MyCountdownTimer(time: startTime)
        workVC.timerStorage = MyTimerStorage()
        workVC.notifications = TimerNotification()
        workVC.image = image
        workVC.delegate = self
        navigationController.pushViewController(workVC, animated: animated)
    }
}

extension WorkCoordinator: TimerVCDelegate {
    
    func done() {
        navigationController.popViewController(animated: animated)
    }
}
