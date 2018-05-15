//
//  CircleView.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 10..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//


import UIKit

class CircleView: UIView {
    
    private var trackLayer: CAShapeLayer!
    private var fillLayer: CAShapeLayer!
    
    var percentVisualAdjustment = 0.04
    
    var percent: Double {
        didSet {
            percent = max(min(percent, percent-percentVisualAdjustment), 0.0)
            fillLayer?.strokeEnd = CGFloat(percent)
        }
    }
    
    private override init(frame: CGRect) {
        percent = 1.0 - percentVisualAdjustment
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        percent = 1.0 - percentVisualAdjustment
        super.init(coder: aDecoder)
    }
    
    init() {
        percent = 1.0 - percentVisualAdjustment
        super.init(frame: CGRect.zero)
    }
    
    private let lineWidth: CGFloat = 30
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: bounds.width/2.0 - lineWidth/2.0,
                                        startAngle: -CGFloat.pi/2,
                                        endAngle: 3*CGFloat.pi/2,
                                        clockwise: true)
        refreshTrackLayer(circularPath)
        refreshFillLayer(circularPath)
    }
    
    private func refreshTrackLayer(_ circularPath: UIBezierPath) {
        trackLayer?.removeFromSuperlayer()
        trackLayer = CAShapeLayer()
        layer.addSublayer(trackLayer)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor.myTintColorTransparent.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.lineCap = kCALineCapRound
        trackLayer.strokeEnd = 1.0
    }
    
    private func refreshFillLayer(_ circularPath: UIBezierPath) {
        fillLayer?.removeFromSuperlayer()
        fillLayer = CAShapeLayer()
        layer.addSublayer(fillLayer)
        
        fillLayer.path = circularPath.cgPath
        fillLayer.fillColor = UIColor.clear.cgColor
        fillLayer.strokeColor = UIColor.myTintColor.cgColor
        fillLayer.lineWidth = lineWidth
        fillLayer.lineCap = kCALineCapRound
        fillLayer.strokeEnd = CGFloat(percent)
    }
}

