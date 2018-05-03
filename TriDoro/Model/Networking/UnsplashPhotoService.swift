//
//  UnsplashPhotoService.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

struct UnsplashPhotoService: PhotoService {

    private let urlSession: URLSession
    private let serviceErrorHandler: ServiceErrorHandler
    
    init(_ urlSession: URLSession = URLSession.shared, serviceErrorHandler: ServiceErrorHandler = ServiceErrorHandler()) {
        self.urlSession = urlSession
        self.serviceErrorHandler = serviceErrorHandler
    }
    
    func getThreeRandomPhotoUrls(_ completion: @escaping (ThreePhotoUrlsResult) -> ()) {
        guard let request = generateRequqestForThreeRandomUrls() else {
            completion(.error(ServiceError.other))
            return
        }
        
        urlSession.dataTask(with: request, completionHandler: { data, _, error in
            if let error = error as NSError? {
                DispatchQueue.main.async {
                    completion(.error(self.serviceErrorHandler.genereateError(fromError: error)))
                }
                return
            } else if let data = data {
                if let result = self.deserializeThreeRandomUrls(data) {
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.error(ServiceError.other))
                    }
                }
            }
        }).resume()
    }
    
    private func generateRequqestForThreeRandomUrls() -> URLRequest? {
        guard let url = URL(string: "https://api.unsplash.com/photos/random?count=3&query=nature") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("v1", forHTTPHeaderField: "Accept-Version")
        request.setValue("Client-ID \(Configuration.unsplashAccessKey)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    private func deserializeThreeRandomUrls(_ data: Data) -> ThreePhotoUrls? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let dict = json as? [Any] {
                var urls = [URL]()
                for photoAny in dict {
                    if let photoDict = photoAny as? [String: Any],
                       let urlsDict = photoDict["urls"] as? [String: String] {
                        if let urlString = urlsDict["regular"],
                           let url = URL(string: urlString) {
                            urls.append(url)
                        }
                    }
                }
                if urls.count == 3 {
                    return urls
                }
            }
        } catch {
            return nil
        }
        return nil
    }
}
