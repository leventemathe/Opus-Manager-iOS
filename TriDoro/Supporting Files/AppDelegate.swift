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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
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
        if let currentVC = coordinator?.currentVC as? TimerVC {
            currentVC.cancelTimer()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if let currentVC = coordinator?.currentVC as? TimerVC {
            currentVC.refreshTimer()
        }
    }
}

