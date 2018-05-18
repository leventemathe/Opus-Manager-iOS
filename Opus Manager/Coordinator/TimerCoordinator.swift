//
//  TimerCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 14..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class TimerCoordinator<VCType: TimerVC, TimerType: MyTimer>: Coordinator {
    
    let navigationController: UINavigationController
    var coordinators = [String : Coordinator]()
    
    let navigationAnimationDelegate: UINavigationControllerDelegate
    
    let startTime: Double
    let time: Double
    let animated: Bool
    var image: UIImage?
    var imageUrl: Photo?
    
    init(navigationAnimationDelegate: UINavigationControllerDelegate,
         navigationController: UINavigationController,
         startTime: Double,
         time: Double,
         animated: Bool,
         image: UIImage?,
         imageUrl: Photo?) {
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
        let vc = VCType()
        vc.timerModel = TimerType(startTime: startTime, time: time)
        vc.timerStorage = MyTimerStorage()
        vc.notifications = TimerNotification()
        vc.photoService = UnsplashPhotoService()
        vc.imageDownloader = ImageDownloader()
        vc.image = image
        vc.imageURL = imageUrl
        vc.delegate = self
        navigationController.pushViewController(vc, animated: animated)
    }
}

extension TimerCoordinator: TimerVCDelegate {
    
    func done() {
        navigationController.popViewController(animated: true)
    }
    
    func showUserProfile(_ url: URL) {
        let userProfileCoordinator = UserProfileCoordinator(navigationController: navigationController, url: url)
        coordinators[String(describing: UserProfileCoordinator.self)] = userProfileCoordinator
        userProfileCoordinator.start()
    }
}
