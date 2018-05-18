//
//  OnboardingPageVC.swift
//  Opus Manager
//
//  Created by Máthé Levente on 2018. 05. 18..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class OnboardingPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let pages: [UIViewController] = [OnboardingOverviewVC.instantiate(),
                                     OnboardingWorkVC.instantiate(),
                                     OnboardingShortBreakVC.instantiate(),
                                     OnboardingLongBreakVC.instantiate()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let current = pages.index(of: viewController) else {
            return nil
        }
        let next = current - 1
        if next < 0 {
            return nil
        }
        return pages[next]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let current = pages.index(of: viewController) else {
            return nil
        }
        let next = current + 1
        if next >= pages.count {
            return nil
        }
        return pages[next]
    }
}
