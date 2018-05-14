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
                startWorkVC(15, time: time, animated: false)
            }
        }
    }
    
    private func calculateDiff(_ oldTime: Double, currentTime: Double) -> Double {
        return currentTime - oldTime
    }
    
    private func startWorkVC(_ startTime: Double, time: Double, animated: Bool, touchPoint: CGPoint? = nil, image: UIImage? = nil, imageUrl: PhotoUrl? = nil) {
        let timerNavigationDelegate = TimerNavigationDelegate(touchPoint: touchPoint ?? navigationController.view.center)
        let workCoordinator = WorkCoordinator(navigationAnimationDelegate: timerNavigationDelegate,
                                              navigationController: navigationController,
                                              startTime: startTime,
                                              time: time,
                                              animated: animated,
                                              image: image,
                                              imageUrl: imageUrl)
        coordinators[SelectorCoordinator.WORK_KEY] = workCoordinator
        workCoordinator.start()
    }
}

extension SelectorCoordinator: SelectorVCDelegate {

    func work(_ touchPoint: CGPoint) {
        let image = selectorVC.workView.imageViewWithOpacityView.image
        let imageUrl = selectorVC.images.count == 3 ? (selectorVC.images.map { $0.1 })[0] : nil
        startWorkVC(15, time: 15, animated: true, touchPoint: touchPoint, image: image, imageUrl: imageUrl)
    }
    
    func shortBreak(_ touchPoint: CGPoint) {
        
    }
    
    func longBreak(_ touchPoint: CGPoint) {
        
    }
}


