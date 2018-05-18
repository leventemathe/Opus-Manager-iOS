//
//  ServiceResult.swift
//  TriDoro
//
//  Created by Máthé Levente on 2018. 05. 03..
//  Copyright © 2018. Levente Máthé. All rights reserved.
//

enum ServiceResult<T> {
    case success(T)
    case error(Error)
}

enum ServiceError: Error {
    case network
    case other
}
