//
//  TimerVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {
    
    let doneButton: LargeButton = {
        var button = LargeButton()
        button.setText(NSLocalizedString("Done", comment: "Label text for done button"))
        return button
    }()
    
    let timerLabel: TimerLabel = {
        var label = TimerLabel()
        return label
    }()
    
    weak var delegate: TimerVCDelegate?
    
    var timerModel: MyTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        setupView()
    }
    
    private func setupModel() {
        timerModel.delegate = timerLabel
        startTimer()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.myBackgroundColor
        setupTimerLabel()
        setupDoneButton()
    }
    
    private func setupTimerLabel() {
        view.addSubview(timerLabel)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timerLabel.layoutIfNeeded()
    }
    
    private func setupDoneButton() {
        view.addSubview(doneButton)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 32).isActive = true
        
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    
    @objc func done() {
        delegate?.done()
    }
    
    func startTimer() {
        timerModel.start()
    }
    
    func cancelTimer() {
        timerModel.cancel()
    }
    
    func refreshTimer() {
        timerModel.refresh()
    }
}
