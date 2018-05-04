//
//  AppCoordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 04..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

struct AppCoordinator: Coordinator {
    
    static let SELECTOR_KEY = "selector"
    
    var navigationController: UINavigationController
    var coordinators = [String: Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    mutating func start() {
        var selectorCoordinator = SelectorCoordinator(navigationController: navigationController)
        coordinators[AppCoordinator.SELECTOR_KEY] = selectorCoordinator
        selectorCoordinator.start()
    }
}


