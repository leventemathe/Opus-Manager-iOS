//
//  MainCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

struct MainCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let selectorVC = SelectorVC.instantiate()
        selectorVC.coordinator = self
        navigationController.pushViewController(selectorVC, animated: false)
    }
    
    func work() {
        let workVC = WorkVC()
        workVC.coordinator = BackToMainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(workVC, animated: true)
    }
    
    func shortBreak() {
        
    }
    
    func longBreak() {
        
    }
}
