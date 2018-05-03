//
//  PhotoService.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

import Foundation

typealias ThreePhotoUrls = [URL]
typealias ThreePhotoUrlsResult = ServiceResult<ThreePhotoUrls>

protocol PhotoService {
    
    func getThreeRandomPhotoUrls(_ completion: @escaping (ThreePhotoUrlsResult) -> ())    
}
