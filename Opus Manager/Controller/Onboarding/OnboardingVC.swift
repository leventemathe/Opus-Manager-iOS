//
//  OnboardingVC.swift
//  Opus Manager
//
//  Created by Máthé Levente on 2018. 05. 18..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController, Storyboarded {
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        delegate?.done()
    }
    
    weak var delegate: OnboardingVCDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
