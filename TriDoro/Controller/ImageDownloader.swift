//
//  ImageDownloader.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import UIKit

typealias ImageDownloaderResult = ServiceResult<UIImage>

struct ImageDownloader {
    
    private let urlSession: URLSession
    private let serviceErrorHandler: ServiceErrorHandler
    
    init(urlSession: URLSession = URLSession.shared,
         serviceErrorHandler: ServiceErrorHandler = ServiceErrorHandler()) {
        self.urlSession = urlSession
        self.serviceErrorHandler = serviceErrorHandler
    }
    
    func downloadImageFrom(_ url: URL, withCompletion completion: @escaping (ImageDownloaderResult) -> ()) {
        let request = URLRequest(url: url)
        urlSession.dataTask(with: request, completionHandler: { data, _, error in
            if let error = error as NSError? {
                DispatchQueue.main.async {
                    completion(.error(self.serviceErrorHandler.genereateError(fromError: error)))
                }
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            }
        }).resume()
    }
}
