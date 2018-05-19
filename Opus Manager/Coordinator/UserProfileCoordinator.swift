//
//  UserProfileCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 14..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit
import SafariServices

class UserProfileCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    var coordinators = [String: Coordinator]()
    
    let url: URL
    
    init(navigationController: UINavigationController, url: URL) {
        self.navigationController = navigationController
        self.url = url
    }
    
    func start() {
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationCapturesStatusBarAppearance = true
        navigationController.topViewController?.present(safariVC, animated: true, completion: nil)
    }
}
