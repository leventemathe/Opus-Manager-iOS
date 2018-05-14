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
    var imageURL: PhotoUrl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        setupView()
    }
    
    private func setupModel() {
        timerModel.delegate = self
        timerModel.start()
    }
    
    func setupView() {
        setupBackground()
        setupTimerLabel()
        setupDoneButton()
    }

    func setupBackground() {
        view.backgroundColor = UIColor.myBackgroundColor
        setupBackgrounImageView()
    }

    private let bacgkroundImageTilt: CGFloat = 100.0
    
    private func setupBackgrounImageView() {
        view.addSubview(backgroundImageView)
        
        setBackgroundImage()
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -bacgkroundImageTilt).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: bacgkroundImageTilt).isActive = true
        
        addParallaxEffectToBackgroundImageView()
    }
    
    private func setBackgroundImage() {
        if let image = image {
            backgroundImageView.image = image
            if let imageURL = imageURL {
                setPhotoFromExistingUrlFromTheService(imageURL)
            }
        } else {
            setRandomPhotoFromTheService()
        }
    }
    
    private func setRandomPhotoFromTheService() {
        photoService.getRandomPhotoUrl { result in
            switch result {
            case .success(let url):
                self.imageDownloader.downloadSmallThenLargeImageFrom(url, withCompletion: { result in
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
    
    private func setPhotoFromExistingUrlFromTheService(_ url: PhotoUrl) {
        imageDownloader.downloadImageFrom(url.large, withCompletion: { result in
            switch result {
            case .success(let image):
                self.backgroundImageView.image = image
            default:
                break
            }
        })
    }
    
    private func addParallaxEffectToBackgroundImageView() {
        let horizontalEffect = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        horizontalEffect.maximumRelativeValue = bacgkroundImageTilt
        horizontalEffect.minimumRelativeValue = -bacgkroundImageTilt
        backgroundImageView.addMotionEffect(horizontalEffect)
    }
    
    func setupTimerLabel() {
        view.addSubview(timerLabel)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timerLabel.layoutIfNeeded()
    }
    
    func setupDoneButton() {
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
    
    func myTimerTimeChanged(_ time: Double, timeString string: String) {
        timerLabel.text = string        
    }
    
    func myTimerStarted(_ time: Double, timeString string: String) {
        timerLabel.text = string
        timerStorage.storeTimer(String(describing: type(of: self)))
    }
    
    func myTimerFinished(_ time: Double, timeString string: String) {
        timerStorage.removeTimer()
    }
}


