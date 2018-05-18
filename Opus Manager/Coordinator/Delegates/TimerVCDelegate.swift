//
//  TimerVCDelegate.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 04..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

protocol TimerVCDelegate: class {
    
    func done()
    func showUserProfile(_ url: URL)
}

