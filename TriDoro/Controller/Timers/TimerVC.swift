//
//  TimerVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class TimerVC: UIViewController, MyTimerDelegate {
    
    let backgroundImageView = ImageViewWithOpacityView()
    
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
    var timerStorage: MyTimerStorage!
    
    var photoService: PhotoService!
    var imageDownloader: ImageDownloader!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        setupView()
    }
    
    private func setupModel() {
        timerModel.delegate = self
        timerModel.start()
    }
    
    private func setupView() {
        setupBackground()
        setupTimerLabel()
        setupDoneButton()
    }

    private func setupBackground() {
        view.backgroundColor = UIColor.myBackgroundColor
        setupBackgrounImageView()
    }

    private let bacgkroundImageTilt: CGFloat = 100.0
    
    private func setupBackgrounImageView() {
        view.addSubview(backgroundImageView)
        if let image = image {
            backgroundImageView.image = image
        } else {
            setBackgroundImageFromTheService()
        }
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -bacgkroundImageTilt).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: bacgkroundImageTilt).isActive = true
        
        addParallaxEffectToBackgroundImageView()
    }
    
    private func setBackgroundImageFromTheService() {
        photoService.getRandomPhotoUrl { result in
            switch result {
            case .success(let url):
                self.imageDownloader.downloadImageFrom(url, withCompletion: { result in
                    switch result {
                    case .success(let image):
                        self.backgroundImageView.image = image
                    default:
                        break
                    }
                })
            default:
                break
            }
        }
    }
    
    private func addParallaxEffectToBackgroundImageView() {
        let horizontalEffect = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        horizontalEffect.maximumRelativeValue = bacgkroundImageTilt
        horizontalEffect.minimumRelativeValue = -bacgkroundImageTilt
        backgroundImageView.addMotionEffect(horizontalEffect)
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
        timerModel.stop()
        delegate?.done()
    }
    
    func myTimerTimeChanged(_ time: String) {
        timerLabel.text = time
    }
    
    func myTimerStarted(_ time: String) {
        timerLabel.text = time
        timerStorage.storeTimer(String(describing: type(of: self)))
    }
    
    func myTimerFinished(_ time: String) {
        timerStorage.removeTimer()
    }
}


