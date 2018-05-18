//
//  AppCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 04..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    static let SELECTOR_KEY = "selector"
    
    var navigationController: UINavigationController
    var coordinators = [String: Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let selectorCoordinator = SelectorCoordinator(navigationController: navigationController)
        coordinators[AppCoordinator.SELECTOR_KEY] = selectorCoordinator
        selectorCoordinator.start()
    }
    
    func pauseTimerIfNeeded() {
        if let currentVC = currentVC as? TimerVC {
            currentVC.timerModel.pause()
        }
    }
    
    func continueTimerIfNeeded() {
        if let currentVC = currentVC as? TimerVC {
            if let timer = currentVC.timerStorage.loadTimer() {
                if let timestamp = timer.values.first {
                    let diff = Date().timeIntervalSince1970 - timestamp - currentVC.timerModel.timeElapsedSinceStart
                    currentVC.timerModel.restart(withTimeElapsed: diff)
                }
            }
        }
    }
}


