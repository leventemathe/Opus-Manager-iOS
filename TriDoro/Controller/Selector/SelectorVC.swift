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
    
    var photoService: PhotoService!
    var imageDownloader: ImageDownloader!
    
    var images = [UIImage]() {
        didSet {
            setImages()
        }
    }
    
    private func setImages() {
        if images.count == 3 {
            workView.setImage(images[0])
            shortBreakView.setImage(images[1])
            longBreakView.setImage(images[2])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = UnsplashPhotoService()
        imageDownloader = ImageDownloader()
        downloadImages()
        setupLabels()
        setupCoordinator()
    }
    
    private func downloadImages() {
        photoService.getThreeRandomPhotoUrls { result in
            switch result {
            case .success(let urls):
                self.downloadImagesFrom(urls: urls)
            default:
                break
            }
        }
    }
    
    private func downloadImagesFrom(urls: [URL]) {
        for url in urls {
            self.imageDownloader.downloadImageFrom(url, withCompletion: { result in
                switch result {
                case .success(let image):
                    self.images.append(image)
                default:
                    break
                }
            })
        }
    }
    
    private func setupLabels() {
        let workText = NSLocalizedString("Work", comment: "Label for work in selector")
        let shortBreakText = NSLocalizedString("Short Break", comment: "Label for short break in selector")
        let longBreakText = NSLocalizedString("Long Break", comment: "Label for long break in selector")
        workView.setLabelText(workText)
        shortBreakView.setLabelText(shortBreakText)
        longBreakView.setLabelText(longBreakText)
    }
    
    private func setupCoordinator() {
        let workTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(workTapped))
        let shortBreakTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(shortBreakTapped))
        let longBreakTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(longBreakTapped))
        
        workView.addGestureRecognizer(workTapRecognizer)
        shortBreakView.addGestureRecognizer(shortBreakTapRecognizer)
        longBreakView.addGestureRecognizer(longBreakTapRecognizer)
    }
    
    @objc private func workTapped() {
        let workVC = WorkVC()
        workVC.modalTransitionStyle = .coverVertical
        workVC.modalPresentationStyle = .overFullScreen
        self.present(workVC, animated: true)
        print("work tapped")
    }
    
    @objc private func shortBreakTapped() {
        print("short break tapped")
    }
    
    @objc private func longBreakTapped() {
        print("long break tapped")
    }
}
