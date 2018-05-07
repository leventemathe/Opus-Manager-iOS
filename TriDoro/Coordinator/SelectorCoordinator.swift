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
    
    var navigationController: UINavigationController
    var coordinators = [String : Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.isNavigationBarHidden = true
        let selectorVC = SelectorVC.instantiate()
        selectorVC.photoService = UnsplashPhotoService()
        selectorVC.imageDownloader = ImageDownloader()
        selectorVC.delegate = self
        navigationController.pushViewController(selectorVC, animated: false)
    }
}

extension SelectorCoordinator: SelectorVCDelegate {

    func work() {
        let workCoordinator = WorkCoordinator(navigationController: navigationController)
        coordinators[SelectorCoordinator.WORK_KEY] = workCoordinator
        workCoordinator.start()
    }
    
    func shortBreak() {
        
    }
    
    func longBreak() {
        
    }
}


