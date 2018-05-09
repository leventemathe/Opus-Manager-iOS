//
//  TimerNavigationDelegate.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 09..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class TimerNavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
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
        let bounds = UIScreen.main.bounds
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        toVC.view.frame = toVC.view.frame.offsetBy(dx: 0, dy: bounds.size.height)
        container.addSubview(toVC.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            toVC.view.frame = finalFrame
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
    private func dismissTimerVC(_ transitionContext: UIViewControllerContextTransitioning, toVC: UIViewController, fromVC: TimerVC) {
        let container = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        
        container.addSubview(toVC.view)
        container.sendSubview(toBack: toVC.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            toVC.view.alpha = 1
            fromVC.view.frame = fromVC.view.frame.offsetBy(dx: 0, dy: bounds.size.height)
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

class TimerNavigationDelegate: NSObject, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TimerNavigationAnimator()
    }
}
