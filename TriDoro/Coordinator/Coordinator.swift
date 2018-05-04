//
//  Coordinator.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 04..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

protocol Coordinator {
 
    var navigationController: UINavigationController { get }
    var coordinators: [String: Coordinator] { get }
    
    mutating func start()
}
