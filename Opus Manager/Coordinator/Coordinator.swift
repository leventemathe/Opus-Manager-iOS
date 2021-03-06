//
//  Coordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 04..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

protocol Coordinator: class {
 
    var navigationController: UINavigationController { get }
    var coordinators: [String: Coordinator] { get set }
    var currentVC: UIViewController? { get }
    
    func start()
}

extension Coordinator {
    
    var currentVC: UIViewController? {
        return navigationController.topViewController
    }
}
