//
//  SelectorVC.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 02..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class SelectorVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var workView: TaskView!
    @IBOutlet weak var shortBreakView: TaskView!
    @IBOutlet weak var longBreakView: TaskView!
    
    var photoService: PhotoService!
    var imageDownloader: ImageDownloader!
    
    weak var delegate: SelectorVCDelegate?
    
    var images = [(UIImage, PhotoUrl)]() {
        didSet {
            print(images)
            setImages()
        }
    }
    
    private func setImages() {
        if images.count == 3 {
            workView.setImage(images[0].0)
            shortBreakView.setImage(images[1].0)
            longBreakView.setImage(images[2].0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
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
    
    private func downloadImagesFrom(urls: [PhotoUrl]) {
        for url in urls {
            print(url)
            self.imageDownloader.downloadImageFrom(url.regular, withCompletion: { result in
                switch result {
                case .success(let image):
                    self.images.append((image, url))
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
        let workTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(workTapped(_:)))
        //let shortBreakTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(shortBreakTapped(_:forEvent:)))
        //let longBreakTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(longBreakTapped(_:forEvent:)))
        
        workView.addGestureRecognizer(workTapRecognizer)
        //shortBreakView.addGestureRecognizer(shortBreakTapRecognizer)
        //longBreakView.addGestureRecognizer(longBreakTapRecognizer)
    }
    
    @objc private func workTapped(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: view)
        delegate?.work(point)
    }
    
    @objc private func shortBreakTapped(_ sender: Any, forEvent event: UIEvent) {

    }
    
    @objc private func longBreakTapped(_ sender: Any, forEvent event: UIEvent) {

    }
}
