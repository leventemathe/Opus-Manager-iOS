//
//  UnsplashLinkButton.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 14..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class UnsplashLinkButton: UIButton {
    
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
        setupFont()
        setupBackground()
    }
    
    private func setupFont() {
        titleLabel?.font = UIFont.myRegularLight
        setTitleColor(UIColor.myTintColor, for: .normal)
        setTitleColor(UIColor.myLightBackgroundColor, for: .highlighted)
    }
    
    private func setupBackground() {
        backgroundColor = UIColor.clear
    }
    
    func setText(_ user: String) {
        let text = NSLocalizedString("Photo by", comment: "Photo by ...") + " " + user + ", Unsplash"
        setTitle(text, for: .normal)
        setTitle(text, for: .highlighted)
    }
}
