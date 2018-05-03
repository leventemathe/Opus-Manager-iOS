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
            if images.count == 3 {
                workView.setImage(images[0])
                shortBreakView.setImage(images[1])
                longBreakView.setImage(images[2])
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoService = UnsplashPhotoService()
        imageDownloader = ImageDownloader()
        downloadImages()
        setupLabels()
    }
    
    private func downloadImages() {
        photoService.getThreeRandomPhotoUrls { result in
            switch result {
            case .success(let urls):
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
            default:
                break
            }
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
}
