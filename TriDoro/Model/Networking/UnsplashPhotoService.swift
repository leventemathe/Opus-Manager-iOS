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
    
    private func getRandomPhotos<T>(_ count: Int, deserializer: @escaping (Data)->(T?), completion: @escaping (ServiceResult<T>) -> ()) {
        guard let request = generateRequqestForRandomUrl(count) else {
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
                if let result = deserializer(data) {
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
    
    func getThreeRandomPhotoUrls(_ completion: @escaping (ThreePhotoUrlsResult) -> ()) {
        getRandomPhotos(3, deserializer: deserializeThreeRandomUrls, completion: completion)
    }
    
    func getRandomPhotoUrl(_ completion: @escaping (PhotoUrlResult) -> ()) {
        getRandomPhotos(1, deserializer: deserializeRandomUrl, completion: completion)
    }
    
    private func generateRequqestForRandomUrl(_ count: Int) -> URLRequest? {
        guard let url = URL(string: "https://api.unsplash.com/photos/random?count=\(count)&query=nature") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("v1", forHTTPHeaderField: "Accept-Version")
        request.setValue("Client-ID \(Configuration.unsplashAccessKey)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    private func deserializeRandomUrls(_ data: Data) -> [PhotoUrl]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let dict = json as? [Any] {
                return getPhotoUrlsFromJsonDict(dict)
            }
        } catch {
            return nil
        }
        return nil
    }
    
    private func getPhotoUrlsFromJsonDict(_ dict: [Any]) -> [PhotoUrl] {
        var urls = [PhotoUrl]()
        for photoAny in dict {
            if let photoDict = photoAny as? [String: Any],
                let urlsDict = photoDict["urls"] as? [String: String],
                let userDict = photoDict["user"] as? [String: Any],
                let linksDict = userDict["links"] as? [String: String],
                let userUrlString = linksDict["html"] {
                if let full = urlsDict["full"],
                    let regular = urlsDict["regular"],
                    let small = urlsDict["small"] {
                    if let fullUrl = URL(string: full),
                        let regularUrl = URL(string: regular),
                        let smallUrl = URL(string: small),
                        let userlUrl = URL(string: userUrlString + "?utm_source=tridoro&utm_medium=referral") {
                        urls.append(PhotoUrl(small: smallUrl, regular: regularUrl, large: fullUrl, userUrl: userlUrl))
                    }
                }
            }
        }
        return urls
    }
    
    private func deserializeRandomUrl(_ data: Data) -> PhotoUrl? {
        if let urls = deserializeRandomUrls(data) {
            return urls.first
        }
        return nil
    }
    
    private func deserializeThreeRandomUrls(_ data: Data) -> [PhotoUrl]? {
        if let urls = deserializeRandomUrls(data) {
            if urls.count == 3 {
                return urls
            }
        }
        return nil
    }
}
