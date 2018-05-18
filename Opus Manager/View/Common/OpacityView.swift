//
//  OpacityView.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 09..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class OpacityView: UIView {

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
        let color = UIColor.myBackgroundColorTransparent
        backgroundColor = color
    }
}
