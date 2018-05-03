//
//  LargeButton.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class LargeButton: UIButton {
    
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
        setupSize()
        setupFont()
        setupBackground()
    }
    
    private func setupSize() {
        translatesAutoresizingMaskIntoConstraints = false
        let width: CGFloat = 190
        let height: CGFloat = 72
        bounds = CGRect(x: 0, y: 0, width: width, height: height)
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupFont() {
        titleLabel?.font = UIFont.myHeaderLight
        setTitleColor(UIColor.myBackgroundColor, for: .normal)
        setTitleColor(UIColor.myLightBackgroundColor, for: .highlighted)
    }
    
    private func setupBackground() {
        backgroundColor = UIColor.myTintColor
        layer.cornerRadius = bounds.height / 2.0
    }
    
    func setText(_ text: String) {
        setTitle(text, for: .normal)
        setTitle(text, for: .highlighted)
    }
}
