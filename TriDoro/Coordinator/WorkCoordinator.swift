//
//  WorkCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class WorkCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var coordinators = [String : Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let workVC = WorkVC()
        workVC.timerModel = MyTimer()
        workVC.delegate = self
        navigationController.pushViewController(workVC, animated: true)
    }
}

extension WorkCoordinator: TimerVCDelegate {
    
    func done() {
        navigationController.popViewController(animated: true)
    }
}
