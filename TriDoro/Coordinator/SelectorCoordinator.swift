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
    
    var selectorVC: SelectorVC!
    
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
        selectorVC = SelectorVC.instantiate()
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
    
    private func startWorkVC(_ startTime: Double, animated: Bool, touchPoint: CGPoint? = nil, image: UIImage? = nil) {
        let timerNavigationDelegate = TimerNavigationDelegate(touchPoint: touchPoint ?? navigationController.view.center)
        let workCoordinator = WorkCoordinator(navigationAnimationDelegate: timerNavigationDelegate, navigationController: navigationController, startTime: startTime, animated: animated, image: image)
        coordinators[SelectorCoordinator.WORK_KEY] = workCoordinator
        workCoordinator.start()
    }
}

extension SelectorCoordinator: SelectorVCDelegate {

    func work(_ touchPoint: CGPoint) {
        let image = selectorVC.workView.imageViewWithOpacityView.image
        startWorkVC(15, animated: true, touchPoint: touchPoint, image: image)
    }
    
    func shortBreak(_ touchPoint: CGPoint) {
        
    }
    
    func longBreak(_ touchPoint: CGPoint) {
        
    }
}


