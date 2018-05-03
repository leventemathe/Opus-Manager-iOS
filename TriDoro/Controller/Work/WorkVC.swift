//
//  WorkVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class WorkVC: TimerVC {
    
    private var workScreenView: TimerScreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCoordinator()
    }
    
    private func setupView() {
        workScreenView = WorkScreenView()
        view.addSubview(workScreenView)
        workScreenView.translatesAutoresizingMaskIntoConstraints = false
        workScreenView.topAnchor.constraint(equalTo: workScreenView.superview!.topAnchor).isActive = true
        workScreenView.bottomAnchor.constraint(equalTo: workScreenView.superview!.bottomAnchor).isActive = true
        workScreenView.leadingAnchor.constraint(equalTo: workScreenView.superview!.leadingAnchor).isActive = true
        workScreenView.trailingAnchor.constraint(equalTo: workScreenView.superview!.trailingAnchor).isActive = true
    }
    
    private func setupCoordinator() {
        workScreenView.doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
}
