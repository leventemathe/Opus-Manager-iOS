//
//  ImageViewWithOpacityView.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 09..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class ImageViewWithOpacityView: UIView {

    let opacityView = OpacityView()
    let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
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
        setupImageView()
        setupOpacityView()
    }
    
    private func setupImageView() {
        imageView.backgroundColor = UIColor.myBackgroundColor
        
        addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupOpacityView() {
        addSubview(opacityView)
        
        opacityView.translatesAutoresizingMaskIntoConstraints = false
        opacityView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        opacityView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        opacityView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        opacityView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
    var image: UIImage? {
        get {
            return imageView.image
        } set {
            imageView.image = newValue
        }
    }
}
