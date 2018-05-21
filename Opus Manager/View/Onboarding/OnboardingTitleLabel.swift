//
//  OnboardingTitleLabel.swift
//  Opus Manager
//
//  Created by Máthé Levente on 2018. 05. 19..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class OnboardingTitleLabel: UILabel {
    
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
            font = UIFont.mySubheaderBold
        case .pad:
            font = UIFont.myHeaderBold
        default:
            font = UIFont.mySubheaderBold
        }
        textColor = UIColor.myTintColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if traitCollection.horizontalSizeClass == .compact {
                font = UIFont.mySubheaderBold
            } else {
                font = UIFont.myHeaderBold
            }
        }
    }
}
