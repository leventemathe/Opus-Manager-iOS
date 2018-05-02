//
//  SelectorVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 02..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class SelectorVC: UIViewController {
    
    @IBOutlet weak var workView: TaskView!
    @IBOutlet weak var shortBreakView: TaskView!
    @IBOutlet weak var longBreakView: TaskView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }
    
    private func setupLabels() {
        let workText = NSLocalizedString("Work", comment: "Label for work in selector")
        let shortBreakText = NSLocalizedString("Short Break", comment: "Label for short break in selector")
        let longBreakText = NSLocalizedString("Long Break", comment: "Label for long break in selector")
        workView.setLabelText(workText)
        shortBreakView.setLabelText(shortBreakText)
        longBreakView.setLabelText(longBreakText)
    }
}
