//
//  TimerVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {
    
    var coordinator: BackToMainCoordinator?
    
    @objc func done() {
        coordinator?.back()
    }
}
