//
//  TimerNavigationDelegate.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 09..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class TimerNavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let touchPoint: CGPoint
    
    init(touchPoint: CGPoint) {
        self.touchPoint = touchPoint
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let toVC = transitionContext.viewController(forKey: .to) as? TimerVC {
            showTimerVC(transitionContext, toVC: toVC)
        } else if let fromVC = transitionContext.viewController(forKey: .from) as? TimerVC,
                  let toVC = transitionContext.viewController(forKey: .to) {
            dismissTimerVC(transitionContext, toVC: toVC, fromVC: fromVC)
        } else {
            transitionContext.completeTransition(false)
        }
    }
    
    private func showTimerVC(_ transitionContext: UIViewControllerContextTransitioning, toVC: TimerVC) {
        let container = transitionContext.containerView
        
        toVC.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        toVC.view.center = touchPoint
        container.addSubview(toVC.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: .curveEaseIn, animations: {
            toVC.view.center = container.center
            toVC.view.transform = CGAffineTransform.identity
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
    private func dismissTimerVC(_ transitionContext: UIViewControllerContextTransitioning, toVC: UIViewController, fromVC: TimerVC) {
        let container = transitionContext.containerView
        
        container.addSubview(toVC.view)
        container.sendSubview(toBack: toVC.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: .curveEaseIn, animations: {
            fromVC.view.center = self.touchPoint
            fromVC.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

class TimerNavigationDelegate: NSObject, UINavigationControllerDelegate {
    
    private let touchPoint: CGPoint
    
    init(touchPoint: CGPoint) {
        self.touchPoint = touchPoint
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TimerNavigationAnimator(touchPoint: touchPoint)
    }
}
