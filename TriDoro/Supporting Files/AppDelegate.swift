//
//  AppDelegate.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 02..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?
    
    var applicationIsFreshlyLaucnhed = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        TimerNotification.askPermission()
        setupMainVC()
        return true
    }

    private func setupMainVC() {
        let navigationVC = UINavigationController()        
        coordinator = AppCoordinator(navigationController: navigationVC)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        pauseTimerIfNeeded()
    }
    
    private func pauseTimerIfNeeded() {
        if let currentVC = coordinator?.currentVC as? TimerVC {
            currentVC.timerModel.pause()
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if !applicationIsFreshlyLaucnhed {
            continueTimerIfNeeded()
        }
        applicationIsFreshlyLaucnhed = false
    }
    
    private func continueTimerIfNeeded() {
        if let currentVC = coordinator?.currentVC as? TimerVC {
            if let timer = currentVC.timerStorage.loadTimer() {
                if let workStartTimestamp = timer[String(describing: WorkVC.self)] {
                    let diff = Date().timeIntervalSince1970-workStartTimestamp
                    currentVC.timerModel.restart(withTimeElapsed: diff)
                }
            }
        }
    }
}

