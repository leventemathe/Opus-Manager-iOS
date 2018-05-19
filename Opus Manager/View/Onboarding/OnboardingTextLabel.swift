//
//  OnboardingTextLabel.swift
//  Opus Manager
//
//  Created by Máthé Levente on 2018. 05. 18..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class OnboardingTextLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    private func commonInit() {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            font = UIFont.myRegularLight
        case .pad:
            font = UIFont.mySubheaderLight
        default:
            font = UIFont.myRegularLight
        }                
        textColor = UIColor.myTintColor
    }
}
