//
//  UserProfileVCDelegate.swift
//  Opus Manager
//
//  Created by Máthé Levente on 2018. 05. 19..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

protocol UserProfileVCDelegate: class {
    
    func showUserProfile(_ url: URL)
}

extension UserProfileVCDelegate where Self: Coordinator {
    
    func showUserProfile(_ url: URL) {
        let userProfileCoordinator = UserProfileCoordinator(navigationController: navigationController, url: url)
        coordinators[String(describing: UserProfileCoordinator.self)] = userProfileCoordinator
        userProfileCoordinator.start()
    }
}
