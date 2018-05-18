//
//  SelectorVCDelegate.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 04..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

protocol SelectorVCDelegate: class {
    
    func work(_ touchPoint: CGPoint)
    func shortBreak(_ touchPoint: CGPoint)
    func longBreak(_ touchPoint: CGPoint)
}
