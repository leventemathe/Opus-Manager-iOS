//
//  PhotoService.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

typealias ThreePhotoUrls = [Photo]
typealias ThreePhotoUrlsResult = ServiceResult<ThreePhotoUrls>
typealias PhotoUrlResult = ServiceResult<Photo>

protocol PhotoService {
    
    func getThreeRandomPhotoUrls(_ completion: @escaping (ThreePhotoUrlsResult) -> ())
    func getRandomPhotoUrl(_ completion: @escaping (PhotoUrlResult) -> ())
}
