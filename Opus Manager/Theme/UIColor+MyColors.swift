//
//  UIColor+MyColors.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 02..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let myTransparency: CGFloat = 0.4
    
    static let myBackgroundColor = UIColor.black
    static let myBackgroundColorTransparent = UIColor.black.withAlphaComponent(UIColor.myTransparency)
    static let myLightBackgroundColor = UIColor.gray
    static let myTintColor = UIColor.white
    static let myTintColorTransparent = UIColor.white.withAlphaComponent(UIColor.myTransparency)
}
