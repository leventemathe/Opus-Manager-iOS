//
//  WorkCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class WorkCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var coordinators = [String : Coordinator]()
    
    let navigationAnimationDelegate: UINavigationControllerDelegate
    
    let startTime: Double
    let time: Double
    let animated: Bool
    var image: UIImage?
    var imageUrl: PhotoUrl?
    
    init(navigationAnimationDelegate: UINavigationControllerDelegate,
         navigationController: UINavigationController,
         startTime: Double,
         time: Double,
         animated: Bool,
         image: UIImage?,
         imageUrl: PhotoUrl?) {
        self.navigationController = navigationController
        self.navigationAnimationDelegate = navigationAnimationDelegate
        self.navigationController.delegate = self.navigationAnimationDelegate
        self.startTime = startTime
        self.time = time
        self.animated = animated
        self.image = image
        self.imageUrl = imageUrl
    }
    
    func start() {
        let workVC = WorkVC()
        workVC.timerModel = MyCountdownTimer(startTime: startTime, time: time)
        workVC.timerStorage = MyTimerStorage()
        workVC.notifications = TimerNotification()
        workVC.photoService = UnsplashPhotoService()
        workVC.imageDownloader = ImageDownloader()
        workVC.image = image
        workVC.imageURL = imageUrl
        workVC.delegate = self
        navigationController.pushViewController(workVC, animated: animated)
    }
}

extension WorkCoordinator: TimerVCDelegate {
    
    func done() {
        navigationController.popViewController(animated: true)
    }
}
