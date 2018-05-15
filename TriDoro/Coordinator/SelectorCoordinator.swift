//
//  SelectorCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class SelectorCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var coordinators = [String : Coordinator]()
    
    let userDefaults: UserDefaults
    
    var selectorVC: SelectorVC!
    
    var workTime = 25.0*60.0
    var shortBreakTime = 5.0*60.0
    
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
        selectorVC.workSessionCounter = WorkSessionCounter()
        selectorVC.delegate = self
        navigationController.pushViewController(selectorVC, animated: false)
    }
    
    private func startTimerVCIfNeeded() {
        if let timerInProgress = userDefaults.object(forKey: MyTimerStorage.TIMER_IN_PROGRESS) as? TimerNameAndStartTimestamp {
            if let startTimestamp = timerInProgress[String(describing: WorkVC.self)] {
                let diff = calculateDiff(startTimestamp, currentTime: Date().timeIntervalSince1970)
                let time = max(workTime - diff, 0.0)
                startWorkVC(workTime, time: time, animated: false)
            } else if let startTimestamp = timerInProgress[String(describing: ShortBreakVC.self)] {
                let diff = calculateDiff(startTimestamp, currentTime: Date().timeIntervalSince1970)
                let time = max(shortBreakTime - diff, 0.0)
                startWorkVC(shortBreakTime, time: time, animated: false)
            } else if let startTimestamp = timerInProgress[String(describing: LongBreakVC.self)] {
                let diff = calculateDiff(startTimestamp, currentTime: Date().timeIntervalSince1970)
                startLongBreakVC(0, time: diff, animated: false)
            }
        }
    }
    
    private func calculateDiff(_ oldTime: Double, currentTime: Double) -> Double {
        return currentTime - oldTime
    }
    
    private func startWorkVC(_ startTime: Double, time: Double, animated: Bool, touchPoint: CGPoint? = nil, image: UIImage? = nil, imageUrl: Photo? = nil) {
        let timerNavigationDelegate = TimerNavigationDelegate(touchPoint: touchPoint ?? navigationController.view.center)
        let workCoordinator = WorkCoordinator(navigationAnimationDelegate: timerNavigationDelegate,
                                              navigationController: navigationController,
                                              startTime: startTime,
                                              time: time,
                                              animated: animated,
                                              image: image,
                                              imageUrl: imageUrl)
        coordinators[String(describing: WorkVC.self)] = workCoordinator
        workCoordinator.start()
    }
    
    private func startShortBreakVC(_ startTime: Double, time: Double, animated: Bool, touchPoint: CGPoint? = nil, image: UIImage? = nil, imageUrl: Photo? = nil) {
        let timerNavigationDelegate = TimerNavigationDelegate(touchPoint: touchPoint ?? navigationController.view.center)
        let shortBreakCoordinator = ShortBreakCoordinator(navigationAnimationDelegate: timerNavigationDelegate,
                                              navigationController: navigationController,
                                              startTime: startTime,
                                              time: time,
                                              animated: animated,
                                              image: image,
                                              imageUrl: imageUrl)
        coordinators[String(describing: ShortBreakVC.self)] = shortBreakCoordinator
        shortBreakCoordinator.start()
    }
    
    private func startLongBreakVC(_ startTime: Double, time: Double, animated: Bool, touchPoint: CGPoint? = nil, image: UIImage? = nil, imageUrl: Photo? = nil) {
        let timerNavigationDelegate = TimerNavigationDelegate(touchPoint: touchPoint ?? navigationController.view.center)
        let longBreakCoordinator = LongBreakCoordinator(navigationAnimationDelegate: timerNavigationDelegate,
                                                          navigationController: navigationController,
                                                          startTime: startTime,
                                                          time: time,
                                                          animated: animated,
                                                          image: image,
                                                          imageUrl: imageUrl)
        coordinators[String(describing: LongBreakCoordinator.self)] = longBreakCoordinator
        longBreakCoordinator.start()
    }
}

extension SelectorCoordinator: SelectorVCDelegate {

    func work(_ touchPoint: CGPoint) {
        let image = selectorVC.workView.imageViewWithOpacityView.image
        let imageUrl = selectorVC.images.count == 3 ? (selectorVC.images.map { $0.1 })[0] : nil
        startWorkVC(workTime, time: workTime, animated: true, touchPoint: touchPoint, image: image, imageUrl: imageUrl)
    }
    
    func shortBreak(_ touchPoint: CGPoint) {
        let image = selectorVC.shortBreakView.imageViewWithOpacityView.image
        let imageUrl = selectorVC.images.count == 3 ? (selectorVC.images.map { $0.1 })[1] : nil
        startShortBreakVC(shortBreakTime, time: shortBreakTime, animated: true, touchPoint: touchPoint, image: image, imageUrl: imageUrl)
    }
    
    func longBreak(_ touchPoint: CGPoint) {
        let image = selectorVC.longBreakView.imageViewWithOpacityView.image
        let imageUrl = selectorVC.images.count == 3 ? (selectorVC.images.map { $0.1 })[2] : nil
        startLongBreakVC(0, time: 0, animated: true, touchPoint: touchPoint, image: image, imageUrl: imageUrl)
    }
}


