//
//  OnboardingVC.swift
//  Opus Manager
//
//  Created by Máthé Levente on 2018. 05. 18..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var backgroundView: ImageViewWithOpacityView!
    @IBOutlet weak var unsplashUserLinkButton: UnsplashLinkButton!
    
    var photoService: PhotoService!
    var imageDownloader: ImageDownloader!
    
    private var user: User?
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        delegate?.done()
    }
    
    @IBAction func unsplashUserLinkButtonTapped(_ sender: UIButton) {
        if let url = user?.url {
            delegate?.showUserProfile(url)
        }
    }
    
    weak var delegate: OnboardingVCDelegate?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        photoService.getRandomPhotoUrl { result in
            switch result {
            case .success(let photo):
                self.user = photo.user
                self.unsplashUserLinkButton.setText(photo.user.name)
                self.downloadSmallImage(photo)
                self.downloadLargeImage(photo)
            default:
                break
            }
        }
    }
    
    private func downloadSmallImage(_ photo: Photo) {
        self.imageDownloader.downloadImageFrom(photo.small, withCompletion: { result in
            switch result {
            case .success(let image):
                if self.backgroundView.image == nil {
                    self.backgroundView.image = image
                }
            default:
                break
            }
        })
    }
    
    private func downloadLargeImage(_ photo: Photo) {
        self.imageDownloader.downloadImageFrom(photo.large, withCompletion: { result in
            switch result {
            case .success(let image):
                self.backgroundView.image = image
            default:
                break
            }
        })
    }
}
