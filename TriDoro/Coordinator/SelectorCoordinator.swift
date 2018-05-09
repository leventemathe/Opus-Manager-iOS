//
//  SelectorCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class SelectorCoordinator: Coordinator {
    
    static let WORK_KEY = "work"
    
    let navigationController: UINavigationController
    var coordinators = [String : Coordinator]()
    
    let userDefaults: UserDefaults
    
    init(navigationController: UINavigationController, userDefaults: UserDefaults = UserDefaults.standard) {
        self.navigationController = navigationController
        self.userDefaults = userDefaults
    }
    
    func start() {
        startSelectorVC()
        startTimerVCIfNeeded()
    }
    
    private func startSelectorVC() {
        navigationController.isNavigationBarHidden = true
        let selectorVC = SelectorVC.instantiate()
        selectorVC.photoService = UnsplashPhotoService()
        selectorVC.imageDownloader = ImageDownloader()
        selectorVC.delegate = self
        navigationController.pushViewController(selectorVC, animated: false)
    }
    
    private func startTimerVCIfNeeded() {
        if let timerInProgress = userDefaults.object(forKey: MyTimerStorage.TIMER_IN_PROGRESS) as? TimerNameAndStartTimestamp {
            if let startTimestamp = timerInProgress[String(describing: WorkVC.self)] {
                let diff = calculateDiff(startTimestamp, currentTime: Date().timeIntervalSince1970)
                let time = max(15.0 - diff, 0.0)
                startWorkVC(time, animated: false)
            }
        }
    }
    
    private func calculateDiff(_ oldTime: Double, currentTime: Double) -> Double {
        return currentTime - oldTime
    }
    
    private func startWorkVC(_ startTime: Double, animated: Bool) {
        let workCoordinator = WorkCoordinator(navigationController: navigationController, startTime: startTime, animated: animated)
        coordinators[SelectorCoordinator.WORK_KEY] = workCoordinator
        workCoordinator.start()
    }
}

extension SelectorCoordinator: SelectorVCDelegate {

    func work() {
        startWorkVC(15, animated: true)
    }
    
    func shortBreak() {
        
    }
    
    func longBreak() {
        
    }
}


